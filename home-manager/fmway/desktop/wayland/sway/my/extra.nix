{ pkgs, sway, ... }: 
rec {
  mod = sway.config.modifier;
  inherit (sway.config) modifier left up right down terminal;
  menu = "fuzzel";
  menu_run = "${pkgs.dmenu}/bin/dmenu_path | ${menu} -d | xargs swaymsg exec --";
  lock = "${pkgs.swaylock-effects}/bin/swaylock";
  btop = "${pkgs.btop}/bin/btop";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  mode = {
    workspace = "Workspace: 0-9 (eDP-1), Shift + 0-9 (HDMI1)";
  };
}
