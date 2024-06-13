{ pkgs, programs, lib, ... }: let

  # var for command
  menu = "${pkgs.fuzzel}/bin/fuzzel";
  menu_run = "${pkgs.dmenu}/bin/dmenu_path | ${menu} -d | xargs swaymsg exec --";
  lock = "${pkgs.swaylock-effects}/bin/swaylock";
  terminal = "${pkgs.foot}/bin/footclient";
  btop = "${pkgs.btop}/bin/btop";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  mode = {
    workspace = "Workspace: 0-9 (eDP-1), Shift + 0-9 (HDMI1)";
  };

  # list command and custom property / value for sway config
  commands = rec {
    directions = [ "left" "right" "up" "down" ];
    exec = str: "exec ${toString str}";
    swaymsg = str: "swaymsg ${toString str}";
    ex-default = com: exec (swaymsg "${mode-default} && ${toString com}");
    switch-workspace = num: "swaymsg workspace number ${toString num}";
    focus = builtins.foldl' (acc: elem: { "${elem}" = "focus ${elem}"; } // acc) {} (directions ++ [ "mode_toggle" "parent" ]);
    move = builtins.foldl' (acc: elem: { "${elem}" = "move ${elem}"; } // acc) {} (directions ++ [ "scratchpad" ]);
    show = builtins.foldl' (acc: elem: { "${elem}" = "${elem} show"; } // acc) {} [ "scratchpad" ];
    toggle = builtins.foldl' (acc: elem: { "${elem}" = "${elem} toggle"; } // acc) {} [ "floating" "fullscreen" ];
    layout = builtins.foldl' (acc: elem: { "${elem}" = "layout ${elem}"; } // acc) {} [ "stacking" "tabbed" "toggle split" ];
    to-workspace = num: "workspace number ${toString num}";
    move-to-workspace = num: "move container to workspace number ${toString num}";
    reload = "reload";
    to-mode = m: ''mode "${toString m}"'';
    split = {
      vertical = "splitv";
      horizontal = "splith";
    };
    resize ={
      left = px: "resize shrink width ${toString px} px";
      right = px: "resize grow width ${toString px} px";
      up = px: "resize shrink height ${toString px} px";
      down = px: "resize grow height ${toString px} px";
    };
    mode-default = ''mode "default"'';
  };
  left = "h";
  down = "j";
  up = "k";
  right = "l";
  mod = "Mod4";

  # get [file.nix...] in current directory
  folder = ./.;
  basename = k: builtins.head (builtins.match "^(.*)\\.(.*)$" (builtins.baseNameOf k));
  excludes = [ "window.nix" ]; # exclude directories
  list = lib.mapAttrsToList (name: value: "${name}") (lib.filterAttrs (key: value: value == "regular" && lib.hasSuffix ".nix" key && key != "default.nix") (builtins.readDir folder)); 

  # Key value parsing for environment 
  env = { ... } @ obj:
    builtins.foldl' (acc: curr:
      acc + "export ${curr}\n"
    ) "" (lib.mapAttrsToList (key: value: "${key}=${toString value}") obj);

in {
  enable = true;
  wrapperFeatures.gtk = true;
  checkConfig = false;
  package = pkgs.swayfx-unwrapped.override {
    trayEnabled = false;
  };

  # read config in all *.nix with some excludes
  config = lib.foldl (acc: curr: {
    "${basename curr}" = import (lib.path.append folder curr) {
        inherit commands pkgs lock left down up right mod menu terminal menu_run mode btop brightnessctl; 
      };
    } // acc
  ) {} (builtins.filter (x: ! builtins.any (y: x == y) excludes) list) // {
    inherit left right up down terminal;
    modifier = mod;
  };

  extraConfig = ''
    xwayland enable
    font pango:Noto Sans 1 
    gaps inner 0
    gaps outer 0
    default_border pixel 4 

    # swayfx feature
    corner_radius 8
    blur enable
    blur_xray disable
    blur_passes 2
    blur_radius 4
    shadows enable
    shadows_on_csd disable
    shadow_blur_radius 16
    shadow_color #0000007F

    default_dim_inactive 0.0
    dim_inactive_colors.unfocused #000000FF
    dim_inactive_colors.urgent #900000FF
    ${import ./window.nix}
  '';

  extraSessionCommands = env {
    SDL_VIDEODRIVER = "wayland";
    # needs qt5.qtwayland in systemPackages
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    # Fix for some Java AWT applications (e.g. Android Studio),
    # use this if they aren't displayed properly:
    _JAVA_AWT_WM_NONREPARENTING = 1;
  };
}
