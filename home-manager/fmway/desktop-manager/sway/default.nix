{ pkgs, programs, ... }: let
  menu = "${pkgs.fuzzel}/bin/fuzzel";
  menu_run = "${pkgs.dmenu}/bin/dmenu_path | ${menu} -d | xargs swaymsg exec --";
  lock = "${pkgs.swaylock-effects}/bin/swaylock";
  mode = {
    workspace = "Workspace: 0-9 (eDP-1), Shift + 0-9 (HDMI1)";
  };
in {
  enable = true;
  wrapperFeatures.gtk = true;
  package = pkgs.swayfx; 
  config = rec {
    left = "h";
    down = "j";
    up = "k";
    right = "l";
    modifier = "Mod4";
    terminal = "${pkgs.foot}/bin/footclient";
    startup = import ./startup.nix { inherit pkgs lock; };
    bars = import ./bars.nix { inherit pkgs; };
    keybindings = import ./keybindings.nix { inherit pkgs left down up right modifier menu terminal menu_run lock mode; };
    modes = import ./modes.nix { inherit pkgs left down up right modifier menu terminal menu_run lock mode; };
    input = {
      "type:touchpad" = {
        natural_scroll = "enabled";
        tap = "enabled";
        middle_emulation = "enabled";
      };
      "type:keyboard" = {
        xkb_variant = ''"qwerty,"'';
        xkb_options = ''"grp:shifts_toggle, caps:none"'';
      };
    };

    output = {
      "*" = {
        bg = "~/.wallpaper fill";
        adaptive_sync = "on";
      };
      HDMI1 = {
        pos = "0 0 res 1920x1080";
      };
      "eDP-1" = {
        pos = "0 0 res 1920x1080";
      };
    };
  };
  extraConfig = ''
    font pango:Noto Sans 0 
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

  extraSessionCommands = ''
    export SDL_VIDEODRIVER=wayland
    # needs qt5.qtwayland in systemPackages
    export QT_QPA_PLATFORM=wayland
    export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
    # Fix for some Java AWT applications (e.g. Android Studio),
    # use this if they aren't displayed properly:
    export _JAVA_AWT_WM_NONREPARENTING=1
  '';
}
