{ inputs, cell }: let
  inherit (inputs) nixpkgs;
  # inherit (inputs.std) lib std;
  l = nixpkgs.lib;
  inherit (l) path throwIfNot mapAttrs' last take pathExists listToAttrs lists splitString mapAttrsToList hasSuffix removeSuffix hasPrefix filterAttrs flatten reverseList recursiveUpdate;
  inherit (builtins) isNull isPath isString functionArgs isFunction isList any readDir head foldl' match length baseNameOf isAttrs hasAttr map attrNames elemAt split readFile filter concatStringsSep toString;

  templateSingleImport = { folder, variables, list, excludes, initial }: let
    inherit (exported) basename excludeItems doImport;
    filtered = if length excludes == 0 then list else excludeItems excludes list;
  in foldl' (acc: curr: {
    "${basename curr}" = doImport (path.append folder curr) variables;
  } // acc) initial filtered;

  exported = rec {
    # basename without extension
    basename = k: let
      bs = baseNameOf k;
      matched = match "^(.*)\\.(.*)$" bs;
    in if matched == null then bs else head matched;

    getFilename = path:
      last (splitString "/" (toString path));

    hasFilename = filename: target:
      if isList filename then
        let
          filtered = filter (x: hasFilename x target) filename;
        in if length filtered < 1 then
          false
        else true
      else let
        target-filename = getFilename target;
      in filename == target-filename;

    hasSuffix' = suffix: target:
      if isList suffix then
        let
          filtered = filter (x: hasSuffix' x target) suffix;
        in if length filtered < 1 then
          false
        else true
      else let
        targetStr = toString target;
      in hasSuffix suffix targetStr;


    hasPrefix' = prefix: target:
      if isList prefix then
        let
          filtered = filter (x: hasPrefix' x target) prefix;
        in if length filtered < 1 then
          false
        else true
      else let
        targetStr = toString target;
      in hasPrefix prefix targetStr;

    hasRegex = regex: target:
      if isList regex then
        let
          filtered = filter (x: hasRegex x target) regex;
        in if length filtered < 1 then false else true
      else let
        targetStr = toString target;
        matched = match regex targetStr;
      in if isNull matched then false else true;

    removeSuffix' = suffix: target:
      if isList suffix then
        let
          filtered = filter (x: hasSuffix' x target) suffix;
        in if length filtered < 1 then
          target
        else removeSuffix' (head filtered) target
      else let
        targetStr = toString target;
      in removeSuffix suffix targetStr;

    # parse args only required to function
    getRequiredArgs = function: variables: let
      args = functionArgs function;
      getArgs = name: _: {
        inherit name;
        value = if hasAttr name variables then variables.${name}
          else if hasAttr name exported then exported.${name}
          else abort "Jangan tolol bang! argument ${name} gak ada :(";
      };
    in mapAttrs' getArgs args;

    doImport = path: variables: let
      imported = import path;
    in if isFunction imported && !isNull variables then
      imported (getRequiredArgs imported variables)
    else imported;

    stringMultiply = str: count:
      foldl' (acc: _: str + acc) "" (lists.range 1 count);

    excludeArray = excludes: inputs: let
      fixed = map (x: toString x) excludes;
      filtering = x: ! any (y: x == y) fixed;
    in filter filtering inputs;

    excludeObj = excludes: inputs: let
      names = excludeArray excludes (attrNames inputs);
      func = acc: name: {
        "${name}" = inputs.${name};
      } // acc;
    in foldl' func {} names;

    excludeItems = excludes: inputs:
    if isList inputs then
      excludeArray excludes inputs
    else if isAttrs inputs then
      excludeObj excludes inputs
    else abort "Tolol bet bjir, lu mau exclude apaan :(";

    excludePrefix = excludes: prefixs: let
      fixed = map (x: toString x) excludes;
      filtering = x: ! any (y: hasPrefix' y x) fixed;
    in filter filtering prefixs;

    excludeSuffix = excludes: suffixs: let
      fixed = map (x: toString x) excludes;
      filtering = x: ! any (y: hasSuffix' y x) fixed;
    in filter filtering suffixs;

    # like tree in shell command, returning array
    tree-path = var: let
      # if var not an object, dir = x, prefix = x; otherwise dir = x.dir, prefix x.prefix / x.dir
      dir = if isAttrs var && var ? dir then 
          var.dir 
        else var;
      prefix = if isAttrs var && var ? prefix && isString var.prefix then
          var.prefix 
        else if isList dir then elemAt dir 0 else dir;

      toList = { attr, prefix, base ? ./. }: 
        map (x: { 
          path = base + ("/" + x); 
          prefix = if prefix == "" then x else prefix + ("/" + x);
          type = attr.${x};
        }) (attrNames attr);

      condition = val: 
        let
          inherit (val) type path prefix;
        in
        if type == "regular" then
          prefix
        else
          all { dir = path; prefix = prefix; };

      all = { dir, prefix }: map condition (toList {
        attr = readDir dir;
        prefix = prefix;
        base = dir;
      });
    in if isList dir then flatten (map (x: tree-path { dir = x; inherit prefix; }) dir) 
      else flatten (all { dir = dir; prefix = prefix; });

    # get all directory that have default.nix
    getDefaultNixs = folder: let
      filtered = key: value:
        value == "directory" &&
        pathExists (path.append folder "${key}/default.nix");
      dir = readDir folder;
    in mapAttrsToList (name: value: "${name}") (filterAttrs filtered dir);
    
    # get all <file>.nix except default.nix
    getNixs = folder: let
      filtered = key: value:
        value == "regular" &&
        hasSuffix' ".nix" key && key != "default.nix";
      dir = readDir folder;
    in mapAttrsToList (name: value: "${name}") (filterAttrs filtered dir);

    # get all <file>.nix except default.nix also all directory that have default.nix
    getNixsWithDefault = folder: (getNixs folder) ++ (getDefaultNixs folder);

    readEnv = file: let
      parseEnv = str: let
        res = split "^([^# ][^= ]+)=(.*)$" str;
      in if isNull res || length res <= 1 then null else elemAt res 1; # key=value => [ key value ]
      no-empty = x: x != ""; # env with no value will be ignored
      listMaybeEnv = splitString "\n" (readFile file);
      list = filter (x: !isNull x) (map parseEnv (filter no-empty listMaybeEnv));
    in listToAttrs (map (curr: {
      name = elemAt curr 0;
      value = elemAt curr 1;
    }) list); # Just to parse .env file to mapAttrs;

    toImport = name: obj: cwd: variables: { suffix ? {}, prefix ? {}, filename ? {}, regex ? {} } @ alias: if ! isAttrs obj then
      obj
    else let
      keys = attrNames (excludeItems [ "imported" ] obj);
      initial = 
        if obj ? imported then
          if hasSuffix' [ ".nix" ] "${obj.imported}" || pathExists "${obj.imported}/default.nix" then
            doImport obj.imported ({ inherit name; } // variables)
          else
            readFile obj.imported
        else {};
      init = if isNull name || ! (obj ? imported) then
        initial
      else let
        func = let
          matchByFilename = let
            names = attrNames filename;
            filtered = filter (x: hasFilename x obj.imported) names;
            result = if length filtered < 1 then null else head filtered;
          in result;
        in if ! isNull matchByFilename then
          filename.${matchByFilename}
        else let
          matchByPrefix = let
            names = attrNames prefix;
            filtered = filter (x: hasPrefix' x (getFilename obj.imported)) names;
            result = if length filtered < 1 then null else head filtered;
          in result;
        in if ! isNull matchByPrefix then
          prefix.${matchByPrefix}
        else let
          matchBySuffix = let
            names = attrNames suffix;
            filtered = filter (x: hasSuffix' x (getFilename obj.imported)) names;
            result = if length filtered < 1 then null else head filtered;
          in result;
        in if ! isNull matchBySuffix then
          suffix.${matchBySuffix}
        else let
          matchByRegex = let
            names = attrNames regex;
            filtered = filter (x: hasRegex x (getFilename obj.imported)) names;
            result = if length filtered < 1 then null else head filtered;
          in result;
        in if ! isNull matchByRegex then
          regex.${matchByRegex}
        else null;
      in if ! isNull func then
        func initial
      else initial;
    in if isAttrs init then foldl' (acc: key: let
      value = obj.${key};
      res = recursiveUpdate {} { 
        "${key}" = let
          __setting = cwd + "/__setting.nix";
          __variable = cwd + "/__variable.nix";
          __alias = cwd + "/__alias.nix";
          set = if pathExists __setting then let
            imported = doImport __setting variables;
          in {
            variables = if imported ? variables then recursiveUpdate variables imported.variables else variables;
            alias = if imported ? alias then recursiveUpdate alias imported.alias else alias;
          } else { inherit variables alias; };
          var = if pathExists __variable then
            recursiveUpdate set.variables (doImport __variable set.variables) 
          else set.variables;
          ali = if pathExists __alias then
            recursiveUpdate set.alias (doImport __alias var)
          else set.alias;
        in toImport key value (cwd + "/${key}") var ali;
      };
    in recursiveUpdate acc res) init keys else init;

    treeImport' = { folder, variables ? null, depth ? 1, excludes ? [], alias ? {}, include ? {} }: let
      lists = tree-path { dir = folder; prefix = ""; };
      suffixs = [ ".txt" ".conf" ] ++ (if include ? suffixs then include.suffixs else []);
      prefixs = if include ? prefixs then include.prefixs else [];
      filenames = if include ? filenames then include.filenames else [];
      regexs = if include ? regexs then include.filenames else [];
      filtered = filter (x:
        hasSuffix' ([".nix"] ++ suffixs) x ||
        hasPrefix' prefixs x ||
        hasFilename filenames x ||
        hasRegex regexs x) lists; # only <file>.nix
      filtered2 = excludePrefix excludes filtered; # excluding excludes
      filtered3 = excludeSuffix [ "__variable.nix" "__alias.nix" "__setting.nix" ] filtered2;
      result1 = map (x: excludeItems [ "default.nix" ] (splitString "/" x)) filtered3;
      final = filter (x: length x >= depth) result1;
      createObj = arr: let
        name = concatStringsSep "/" arr;
        # res = doImport (folder + "/${name}") variables;
        res = { imported = folder + "/${name}"; };
        
        arre = if length arr < 1 then arr else let
          lasted = last arr;
        in (take (length arr - 1) arr) ++ [ (removeSuffix' ([ ".nix" ] ++ suffixs) lasted)];
      in foldl' (acc: name: let
        obj = if name == "" then # top-level default.nix will be ""
            acc
          else
            { "${name}" = acc; };
      in obj) res (reverseList arre); # [ "the" "array" ] => { the = array = {} }; 

      # fold' (acc1: curr1: lib.recursiveUpdate acc1 (fold' (acc: curr: { "${curr}" = acc; }) {} (reverse curr1))) {} anu
      res = foldl' (acc: curr:
          recursiveUpdate acc (createObj curr)
      ) {} final;
    in toImport null res folder variables alias;

    # treeImport = obj: treeImport' obj {};
    treeImport = obj: if obj ? folder then
      excludeItems ["__functor"] (treeImport' obj)
    else
      recursiveUpdate obj { __functor = self: args: recursiveUpdate (excludeItems ["__functor"] self) (treeImport args); };
    
    genTreeImports' = folder: excludes: let
      list = tree-path { dir = folder; prefix = ""; };
      filtered = filter (x: hasSuffix' ".nix" (toString x)) list;
      excluded = excludePrefix excludes filtered;
    in map (x: folder + "/${x}") excluded;
    
    genTreeImports = folder: genTreeImports' folder [];

    # generate array for imports keyword using getNixs
    genImports' = folder: excludes: let
      list = getNixs folder;
      excluded = excludeItems excludes list;
    in foldl' (acc: curr: [
      (path.append folder curr)
    ] ++ acc) [] excluded;

    genImports = folder: genImports' folder [];

    firstChar = str:
      head (filter (x: x != "") (flatten (split "(.)" str)));
    
    # generate array for imports keyword using getDefaultNixs
    genDefaultImports' = folder: excludes: let
      list = getDefaultNixs folder;
      excluded = excludeItems excludes list;
    in foldl' (acc: curr: [
      (path.append folder curr)
    ] ++ acc) [] excluded;

    genDefaultImports = folder: genDefaultImports' folder [];

    # generate array for imports keyword using getNixsWithDefault
    genImportsWithDefault' = folder: excludes: let
      list = getNixsWithDefault folder;
      excluded = excludeItems excludes list;
    in foldl' (acc: curr: [
      (path.append folder curr)
    ] ++ acc) [] excluded;

    genImportsWithDefault = folder: genImportsWithDefault' folder [];
    
    # generate object for single import for all <file>.nix exclude default.nix
    customImport' = var: let
      folder = if isPath var then var else var.folder;
      excludes = if isAttrs var && var ? excludes && isList var.excludes then var.excludes else [];
      variables = if isAttrs var && var ? variables && isAttrs var.variables then var.variables else if isPath var then null else {};
    in if isList folder then
      foldl' (acc: curr: recursiveUpdate acc (customImport' {
        folder = curr;
        inherit excludes variables;
      })) {} folder 
    else let
      list = getNixs folder;
    in templateSingleImport { inherit folder variables list excludes; initial = {}; };

    # customImport = var: customImport' var {};
    customImport = var: if (var ? folder) || isPath var then
      excludeItems ["__functor"] (customImport' var)
    else
      recursiveUpdate var { __functor = self: args: recursiveUpdate (excludeItems ["__functor"] self) (customImport args); };
    
    # generate object for single import for all directory that have default.nix
    customDefaultImport' = var: let
      folder = if isPath var then var else var.folder;
      variables = if isAttrs var && var ? variables && isAttrs var.variables then var.variables else if isPath var then null else {};
      excludes = if isAttrs var && var ? excludes && isList var.excludes then var.excludes else [];
    in if isList folder then
      foldl' (acc: curr: recursiveUpdate acc (customDefaultImport' {
        folder = curr;
        inherit excludes variables;
      })) {} folder 
    else let
      list = getDefaultNixs folder;
    in templateSingleImport { inherit folder variables list excludes; initial = {}; };

    # customDefaultImport = var: customDefaultImport' var {};
    customDefaultImport = var: if (var ? folder) || isPath var then
      excludeItems ["__functor"] (customDefaultImport' var)
    else
      recursiveUpdate var { __functor = self: args: recursiveUpdate (excludeItems ["__functor"] self) (customDefaultImport args); };

    # generate object for single import for all <file>.nix except default.nix also all directory that have default.nix
    customImportWithDefault' = var: let
      folder = if isPath var then var else var.folder;
      variables = if isAttrs var && var ? variables && isAttrs var.variables then var.variables else if isPath var then null else {};
      excludes = if isAttrs var && var ? excludes && isList var.excludes then var.excludes else [];
    in if isList folder then
      foldl' (acc: curr: recursiveUpdate acc (customImportWithDefault' {
        folder = curr;
        inherit excludes variables;
      })) {} folder 
    else let
      list = getNixsWithDefault folder;
    in templateSingleImport { inherit folder variables list excludes; initial = {}; };

    # customImportWithDefault = var: customImportWithDefault' var {};
    customImportWithDefault = var: if (var ? folder) || isPath var then
      excludeItems ["__functor"] (customImportWithDefault' var)
    else
      recursiveUpdate var { __functor = self: args: recursiveUpdate (excludeItems ["__functor"] self) (customImportWithDefault args); };

    # parse env in folder /etc/nixos/secrets
    getEnv = entity: let
      secretFolder = inputs.self + "/secrets";
      path = secretFolder + "/${entity}.env";
      exists = pathExists path;
    in throwIfNot exists "tidak dapat mencari env dengan nama ${entity}" readEnv path;

    inherit inputs cell;
    
    # generate path to array
    genPaths = home: paths: 
      foldl' (acc: curr: [ "${home}/${curr}/bin" ] ++ acc) [] (reverseList paths);
  };
in exported
