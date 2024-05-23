{ pkgs, ... }:
{
  xdman = pkgs.callPackage ./xdman {  };
  filebrowser = pkgs.callPackage ./filebrowser { };
}
