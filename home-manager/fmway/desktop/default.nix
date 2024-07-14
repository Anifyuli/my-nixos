{ programs, getDefaultNixs, pkgs, lib, ... }:
{
  # read all dir with ./**/*.defalut.nix and import them to wayland.windowManager
  wayland.windowManager = let 
    folder = ./wayland;
  in builtins.foldl' (acc: curr: {
      "${curr}" = import (lib.path.append folder curr) { inherit programs pkgs lib; };
    } // acc) {} (getDefaultNixs folder);
}
