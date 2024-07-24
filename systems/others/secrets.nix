# Hidden secrets using agenix
{ lib, ... }:
let
  inherit (builtins) isList foldl' baseNameOf elemAt isNull attrNames filter readDir match toString;
  inherit (lib) recursiveUpdate;
  getNameAge = value: let
    matched = match "^(.*)\\.age$" (toString value);
  in if isList matched then baseNameOf (elemAt matched 0) else matched;
  hasDotAge = value: if isNull (getNameAge value) then false else true;

  folder = ../../secrets;
  allDir = readDir folder;
  allDirKeys = attrNames allDir;
  filterAgeFiles = key: allDir.${key} == "regular" && hasDotAge key;
  filteredKeys = filter filterAgeFiles allDirKeys;
  age.secrets = foldl' (acc: file: let
    name = getNameAge file;
  in recursiveUpdate acc {
    "${name}" = {
      file = folder + ("/" + file);
      path = "/etc/secrets/${name}";
    };
  }) {} filteredKeys;
in {
  inherit age;
}
