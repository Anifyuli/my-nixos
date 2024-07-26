{ lib, config, pkgs, ... }: let
  inherit (lib) mkOption types;
in {
  options.wayland.windowManager.sway.my = {
    extra = mkOption {
      type = types.attrs;
      default = {};
    };
  };
}
