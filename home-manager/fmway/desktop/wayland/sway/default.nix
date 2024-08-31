{ pkgs, lib, ... }:
{
  enable = true;
  wrapperFeatures.gtk = true;
  checkConfig = false;
  package = pkgs.swayfx-unwrapped.override {
    trayEnabled = false;
  };
  catppuccin.enable = true;
  catppuccin.flavor = "macchiato";
}
