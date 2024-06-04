{ programs, pkgs, lib, ... }: let
  getDefaultNixs = folder: lib.mapAttrsToList (name: value: "${name}") (lib.filterAttrs (key: value: value == "directory" && lib.pathExists (lib.path.append folder "${key}/default.nix")) (builtins.readDir folder));
in {
  # read all dir with ./**/*.defalut.nix and import them to wayland.windowManager
  wayland.windowManager = let 
    folder = ./.;
  in builtins.foldl' (acc: curr: {
      "${curr}" = import (lib.path.append folder curr) { inherit programs pkgs lib; };
    } // acc) {} (getDefaultNixs folder);
}
