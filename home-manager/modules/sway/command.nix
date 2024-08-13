{ lib, config, pkgs, ... }: let
  inherit (lib)
    mkBefore
    mkOption
    types
    ;

  inherit (builtins)
    foldl'
    ;

  inherit (pkgs.functions)
    firstChar
    ;

  template = callback: acc: elem: { "${elem}" = callback elem; } // acc;
  generator = callback: features: foldl' (template callback) {} features;
  # cfg = config.wayland.windowManager.sway.my.command;

in {
  options.wayland.windowManager.sway.my.command = mkOption {
    type = types.attrs;
    default = {};
  };
  config.wayland.windowManager.sway.my.command = mkBefore rec {
    directions = [ "left" "right" "up" "down" ];
    exec = str: "exec ${toString str}";
    swaymsg = str: "swaymsg ${toString str}";
    ex-default = com: exec (swaymsg "${mode-default} && ${toString com}");
    switch-workspace = num: "swaymsg workspace number ${toString num}";
    focus = generator (x: "focus ${x}") (directions ++ [ "mode_toggle" "parent" ]);
    move = generator (x: "move ${x}") (directions ++ [ "scratchpad" ]);
    show = generator (x: "${x} show") [ "scratchpad" ];
    toggle = generator (x: "${x} toggle") [ "floating" "fullscreen" ];
    layout = generator (x: "layout ${x}") [ "stacking" "tabbed" "toggle split" ];
    split = generator (x: "split${firstChar x}") [ "horizontal" "vertical" ];
    to-workspace = num: "workspace number ${toString num}";
    move-to-workspace = num: "move container to workspace number ${toString num}";
    reload = "reload";
    to-mode = m: ''mode "${toString m}"'';

    resize = generator (x: px: let
      go = if x == "left" || x == "up" then "shrink" else "grow";
      to = if x == "left" || x == "right" then "width" else "height";
    in "resize ${go} ${to} ${toString px} px") directions;

    mode-default = ''mode "default"'';
    };
}
