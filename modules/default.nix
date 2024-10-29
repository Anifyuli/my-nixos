{ lib, ... }:
# Import all default.nix from directories
let
  folder = ./.;
  toImport = name: value: folder + "/${name}";
  filterIsThatADirectoryAndHaveDefaultNix = key: value:
  value == "directory" &&
  lib.pathExists (folder + "/${key}/default.nix");
in {
  imports = lib.mapAttrsToList toImport (lib.filterAttrs filterIsThatADirectoryAndHaveDefaultNix (builtins.readDir folder));
}
