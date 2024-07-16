{ customDefaultImport, pkgs, lib, ... }:
{
  # read all dir with ./**/*.defalut.nix and import them to wayland.windowManager
  wayland.windowManager = customDefaultImport {
    folder = ./wayland;
    variables = { inherit pkgs lib; };
  };
}
