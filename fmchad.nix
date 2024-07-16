# My Great function especially for import :v

{ lib
, ...
}: let
  inherit (lib) path pathExists splitString mapAttrsToList hasSuffix filterAttrs flatten reverseList;
  inherit (builtins) isNull isPath isString isList any readDir head foldl' match length baseNameOf isAttrs hasAttr map attrNames elemAt split readFile filter typeOf;
  
  # basename without extension
  basename = k: let
    matched = match "^(.*)\\.(.*)$" (baseNameOf k);
  in if matched == null then k else head matched;

  templateSingleImport = { folder, variables, list, excludes }: let
    filtering = x: ! any (y: x == y) excludes;
    filtered = if length excludes == 0 then list else filter filtering list;
  in foldl' (acc: curr: {
    "${basename curr}" = if isNull variables then
      import (path.append folder curr) 
    else import (path.append folder curr) variables;
  } // acc) {} filtered;

in rec {
  inherit basename;

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

  # generate array for imports keyword using getNixs
  genImports = folder: foldl' (acc: curr: [
    (path.append folder curr)
  ] ++ acc) [] (getNixs folder);
  
  # generate array for imports keyword using getDefaultNixs
  genDefaultImports = folder: foldl' (acc: curr: [
    (path.append folder curr)
  ] ++ acc) [] (getDefaultNixs folder);
  
  # generate object for single import for all <file>.nix exclude default.nix
  customImport = var: let
    folder = if isPath var then var else var.folder;
    variables = if isAttrs var && hasAttr "variables" var then var.variables else null;
    list = getNixs folder;
    excludes = if isAttrs var && hasAttr "excludes" var && isList var.excludes then var.excludes else [];
  in templateSingleImport { inherit folder variables list excludes; };
  
  # generate object for single import for all directory that have default.nix
  customDefaultImport = var: let
    folder = if isPath var then var else var.folder;
    variables = if isAttrs var && hasAttr "variables" var then var.variables else null;
    excludes = if isAttrs var && hasAttr "excludes" var && isList var.excludes then var.excludes else [];
    list = getDefaultNixs folder;
  in templateSingleImport { inherit folder variables list excludes; };

  # like tree in shell command, returning array
  tree-path = var: let
    # if var not an object, dir = x, prefix = x; otherwise dir = x.dir, prefix x.prefix / x.dir
    dir = if isAttrs var && hasAttr "dir" var then 
        var.dir 
      else var;
    prefix = if isAttrs var && hasAttr"prefix" var then
        var.prefix 
      else dir;

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

  in flatten (all { dir = dir; prefix = prefix; });

  readEnv = file: let
    parseEnv = str: elemAt (split "^([^= ]+)=(.*)$" str) 1; # key=value => [ key value ]
    no-empty = x: x != ""; # env with no value will be ignored
    listMaybeEnv = splitString "\n" (readFile file);
    list = map parseEnv (filter no-empty listMaybeEnv);
  in foldl' (acc: curr: {
    "${elemAt curr 0}" = "${elemAt curr 1}";
  } // acc) {} list; # Just to parse .env file to mapAttrs

  # parse env in folder ./secrets
  getEnv = entity: readEnv (path.append ./secrets "${entity}.env");
  
  # generate path to array
  genPaths = home: paths: 
    foldl' (acc: curr: [ "${home}/${curr}/bin" ] ++ acc) [] (reverseList paths);
}
