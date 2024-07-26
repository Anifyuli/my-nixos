# My Great function especially for import :v

{ lib
, pkgs ? null
, ...
}: let
  inherit (lib) path pathExists lists last splitString mapAttrsToList hasSuffix warn removeSuffix hasPrefix removePrefix filterAttrs flatten reverseList recursiveUpdate;
  inherit (builtins) isNull isPath isString functionArgs isFunction isList any readDir head foldl' match length baseNameOf isAttrs hasAttr map attrNames elemAt split readFile filter typeOf concatStringsSep toString;
  
  # basename without extension
  basename = k: let
    matched = match "^(.*)\\.(.*)$" (baseNameOf k);
  in if matched == null then k else head matched;

  # parse args only required to function
  getRequiredArgs = function: variables: let
    args = functionArgs function;
    argNames = attrNames args;
    getArgs = acc: name: {
      "${name}" = if ! isNull pkgs && name == "pkgs" && ! hasAttr name variables then pkgs 
        else if hasAttr name variables then variables.${name}
        else if ! isNull pkgs && hasAttr name pkgs then pkgs.${name}
        else if hasAttr name exported then exported.${name}
        else abort "Jangan tolol bang! argument ${name} gak ada :(";
    } // acc;
  in foldl' getArgs {} argNames;

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
    filtering = x: ! any (y: hasPrefix y x) fixed;
  in filter filtering prefixs;

  excludeSuffix = excludes: suffixs: let
    fixed = map (x: toString x) excludes;
    filtering = x: ! any (y: hasSuffix y x) fixed;
  in filter filtering suffixs;

  templateSingleImport = { folder, variables, list, excludes, initial }: let
    filtered = if length excludes == 0 then list else excludeItems excludes list;
  in foldl' (acc: curr: let
    imported = import (path.append folder curr);
  in {
    "${basename curr}" = if isFunction imported && ! isNull variables then
       imported (getRequiredArgs imported variables)
    else imported;
  } // acc) initial filtered;

  # like tree in shell command, returning array
  tree-path = var: let
    # if var not an object, dir = x, prefix = x; otherwise dir = x.dir, prefix x.prefix / x.dir
    dir = if isAttrs var && hasAttr "dir" var then 
        var.dir 
      else var;
    prefix = if isAttrs var && hasAttr "prefix" var && isString var.prefix then
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
      hasSuffix ".nix" key && key != "default.nix";
    dir = readDir folder;
  in mapAttrsToList (name: value: "${name}") (filterAttrs filtered dir);

  # get all <file>.nix except default.nix also all directory that have default.nix
  getNixsWithDefault = folder: (getNixs folder) ++ (getDefaultNixs folder);

  readEnv = file: let
    parseEnv = str: elemAt (split "^([^= ]+)=(.*)$" str) 1; # key=value => [ key value ]
    no-empty = x: x != ""; # env with no value will be ignored
    listMaybeEnv = splitString "\n" (readFile file);
    list = map parseEnv (filter no-empty listMaybeEnv);
  in foldl' (acc: curr: {
    "${elemAt curr 0}" = "${elemAt curr 1}";
  } // acc) {} list; # Just to parse .env file to mapAttrs

  toImport = obj: cwd: variables: if ! isAttrs obj then
    obj
  else let
    keys = attrNames (excludeItems [ "imported" ] obj);
    initial = 
      if obj ? imported then
        (let
          imported = import obj.imported;
        in if isFunction imported && ! isNull variables then
          imported (getRequiredArgs imported variables)
        else imported)
      else {};
  in foldl' (acc: key: let
    value = obj.${key};
    res = recursiveUpdate {} { 
      "${key}" = let
        __variable = cwd + "/__variable.nix";
        var = if pathExists __variable then
          recursiveUpdate variables (let
            imported = import __variable;
          in if isFunction imported && ! isNull variables then
            imported (getRequiredArgs imported variables)
          else imported)
        else {};
      in toImport value (cwd + "/${key}") (variables // var);
    };
  in recursiveUpdate acc res) initial keys;

  treeImport = { folder, variables ? null, depth ? 1, excludes ? [] }: initial: let
    lists = tree-path { dir = folder; prefix = ""; };
    filtered = filter (x: hasSuffix ".nix" x) lists; # only <file>.nix
    filtered2 = excludePrefix excludes filtered; # excluding excludes
    filtered3 = excludeSuffix [ "__variable.nix" ] filtered2;
    result1 = map (x: excludeItems [ "default.nix" ] (splitString "/" x)) filtered3;
    final = filter (x: length x >= depth) result1;
    createObj = arr: let
      name = concatStringsSep "/" arr;
      # imported = import (folder + "/${name}");
      # res = if isFunction imported && ! isNull variables then
      #     imported (getRequiredArgs imported variables)
      #   else imported;
      res = { imported = folder + "/${name}"; };
    in foldl' (acc: curr: let
      name = removeSuffix ".nix" curr;
      obj = if name == "" then # top-level default.nix will be ""
          acc
        else
          { "${name}" = acc; };
    in obj) res (reverseList arr); # [ "the" "array" ] => { the = array = {} }; 

    # fold' (acc1: curr1: lib.recursiveUpdate acc1 (fold' (acc: curr: { "${curr}" = acc; }) {} (reverse curr1))) {} anu
    res = foldl' (acc: curr:
        recursiveUpdate acc (createObj curr)
    ) initial final;
  in toImport res folder variables;
  
  genTreeImports = folder: excludes: let
    list = tree-path { dir = folder; prefix = ""; };
    filtered = filter (x: hasSuffix ".nix" (toString x)) list;
    excluded = excludePrefix excludes filtered;
  in map (x: folder + "/${x}") excluded;

  # generate array for imports keyword using getNixs
  genImports = folder: excludes: let
    list = getNixs folder;
    excluded = excludeItems excludes list;
  in foldl' (acc: curr: [
    (path.append folder curr)
  ] ++ acc) [] excluded;

  firstChar = str:
    head (filter (x: x != "") (flatten (split "(.)" str)));
  
  # generate array for imports keyword using getDefaultNixs
  genDefaultImports = folder: excludes: let
    list = getDefaultNixs folder;
    excluded = excludeItems excludes list;
  in foldl' (acc: curr: [
    (path.append folder curr)
  ] ++ acc) [] excluded;

  # generate array for imports keyword using getNixsWithDefault
  genImportsWithDefault = folder: excludes: let
    list = getNixsWithDefault folder;
    excluded = excludeItems excludes list;
  in foldl' (acc: curr: [
    (path.append folder curr)
  ] ++ acc) [] excluded;
  
  # generate object for single import for all <file>.nix exclude default.nix
  customImport = var: initial: let
    folder = if isPath var then var else var.folder;
    excludes = if isAttrs var && hasAttr "excludes" var && isList var.excludes then var.excludes else [];
    variables = if isAttrs var && hasAttr "variables" var && isAttrs var.variables then var.variables else if isPath var then null else {};
  in if isList folder then
    foldl' (acc: curr: customImport {
      folder = curr;
      inherit excludes variables;
    } acc) initial folder 
  else let
    list = getNixs folder;
  in templateSingleImport { inherit folder variables list excludes initial; };
  
  # generate object for single import for all directory that have default.nix
  customDefaultImport = var: initial: let
    folder = if isPath var then var else var.folder;
    variables = if isAttrs var && hasAttr "variables" var && isAttrs var.variables then var.variables else if isPath var then null else {};
    excludes = if isAttrs var && hasAttr "excludes" var && isList var.excludes then var.excludes else [];
  in if isList folder then
    foldl' (acc: curr: customDefaultImport {
      folder = curr;
      inherit excludes variables;
    } acc) initial folder 
  else let
    list = getDefaultNixs folder;
  in templateSingleImport { inherit folder variables list excludes initial; };

  # generate object for single import for all <file>.nix except default.nix also all directory that have default.nix
  customImportWithDefault = var: initial: let
    folder = if isPath var then var else var.folder;
    variables = if isAttrs var && hasAttr "variables" var && isAttrs var.variables then var.variables else if isPath var then null else {};
    excludes = if isAttrs var && hasAttr "excludes" var && isList var.excludes then var.excludes else [];
  in if isList folder then
    foldl' (acc: curr: customImportWithDefault {
      folder = curr;
      inherit excludes variables;
    } acc) initial folder 
  else let
    list = getNixsWithDefault folder;
  in templateSingleImport { inherit folder variables list excludes initial; };

  # parse env in folder ./secrets
  getEnv = entity: readEnv (path.append ./secrets "${entity}.env");
  
  # generate path to array
  genPaths = home: paths: 
    foldl' (acc: curr: [ "${home}/${curr}/bin" ] ++ acc) [] (reverseList paths);

  exported = {
      inherit basename excludeItems tree-path getDefaultNixs getNixs getNixsWithDefault readEnv excludePrefix excludeSuffix treeImport genImports genDefaultImports genImportsWithDefault getEnv genPaths customImport customDefaultImport customImportWithDefault genTreeImports getRequiredArgs excludeObj excludeArray toImport firstChar stringMultiply;
  };

in exported
