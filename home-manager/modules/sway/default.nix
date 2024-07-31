{ lib, config, pkgs, ... }: let
  inherit (lib) mkAfter mkIf mkOption types;
  inherit (builtins) foldl' attrNames length;
  cfg = config.wayland.windowManager.sway.my;
in {
  options.wayland.windowManager.sway.my = {
    extra = mkOption {
      type = types.attrs;
      default = {};
    };
  };
  config = {};
}
