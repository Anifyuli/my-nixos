{ lib, ... }: let
  inherit (lib)
    mkOption
    types
    ;
  # cfg = config.wayland.windowManager.sway.my;
in {
  options.wayland.windowManager.sway.my = {
    extra = mkOption {
      type = types.attrs;
      default = {};
    };
  };
  config = {};
}
