{ pkgs, command, extra, ... }: let
  inherit (extra) left down up right mod menu terminal menu_run lock mode brightnessctl btop;
  inherit (command) exec focus move split layout to-workspace to-mode move-to-workspace toggle reload show;
in {
  # Standart keybind
  "${mod}+Return" = exec terminal;
  "${mod}+Shift+q" = "kill";
  "${mod}+d" = exec menu;
  "${mod}+Shift+d" = exec menu_run;

  "${mod}+i" = exec "delock";

  "${mod}+${left}" = focus.left;
  "${mod}+${down}" = focus.down;
  "${mod}+${up}" = focus.up;
  "${mod}+${right}" = focus.right;

  "${mod}+Left" = focus.left;
  "${mod}+Down" = focus.down;
  "${mod}+Up" = focus.up;
  "${mod}+Right" = focus.right;

  "${mod}+Shift+${left}" = move.left;
  "${mod}+Shift+${down}" = move.down;
  "${mod}+Shift+${up}" = move.up;
  "${mod}+Shift+${right}" = move.right;

  "${mod}+Shift+Left" = move.left;
  "${mod}+Shift+Down" = move.down;
  "${mod}+Shift+Up" = move.up;
  "${mod}+Shift+Right" = move.right;

  "${mod}+b" = split.horizontal;
  "${mod}+v" = split.vertical;
  "${mod}+f" = toggle.fullscreen;
  "${mod}+a" = focus.parent;

  "${mod}+s" = layout.stacking;
  "${mod}+w" = layout.tabbed;
  "${mod}+e" = layout."toggle split";

  "${mod}+Shift+space" = toggle.floating;
  "${mod}+space" = focus.mode_toggle;

  "${mod}+1" = to-workspace 1;
  "${mod}+2" = to-workspace 2;
  "${mod}+3" = to-workspace 3;
  "${mod}+4" = to-workspace 4;
  "${mod}+5" = to-workspace 5;
  "${mod}+6" = to-workspace 6;
  "${mod}+7" = to-workspace 7;
  "${mod}+8" = to-workspace 8;
  "${mod}+9" = to-workspace 9;

  "${mod}+Shift+1" = move-to-workspace 1;
  "${mod}+Shift+2" = move-to-workspace 2;
  "${mod}+Shift+3" = move-to-workspace 3;
  "${mod}+Shift+4" = move-to-workspace 4;
  "${mod}+Shift+5" = move-to-workspace 5;
  "${mod}+Shift+6" = move-to-workspace 6;
  "${mod}+Shift+7" = move-to-workspace 7;
  "${mod}+Shift+8" = move-to-workspace 8;
  "${mod}+Shift+9" = move-to-workspace 9;

  "${mod}+Shift+minus" = move.scratchpad;
  "${mod}+minus" = show.scratchpad;

  # fn keys
  "XF86AudioRaiseVolume" = exec "amixer sset Master 2%+";
  "XF86AudioLowerVolume" = exec "amixer sset Master 2%-";
  "XF86AudioMute" = exec "amixer sset Master toggle";
  "XF86MonBrightnessUp" = exec "${brightnessctl} s +2%";
  "XF86MonBrightnessDown" = exec "${brightnessctl} s 2%-";


  "${mod}+Shift+r" = reload;
  "${mod}+Shift+e" =
    exec "swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

  "${mod}+r" = to-mode "resize";

  "${mod}+Shift+p" = to-mode mode.workspace;
}
