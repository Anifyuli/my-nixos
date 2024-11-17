{ pkgs, ... }:
{
  portal = {
    enable = true;
    wlr.enable = true; # enable xdg-desktop-portal-wlr
  };
}
