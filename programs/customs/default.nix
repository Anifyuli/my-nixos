{ pkgs, ... }:
{
  xdman = pkgs.callPackage ./xdman {  };
  caddy = pkgs.callPackage ./caddy { };
  filebrowser = pkgs.callPackage ./filebrowser { };
}
