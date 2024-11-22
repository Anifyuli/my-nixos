{ config, ... }: let
in rec {
  inherit (config.wayland.windowManager) sway;
  inherit (sway.my) command extra;
}
