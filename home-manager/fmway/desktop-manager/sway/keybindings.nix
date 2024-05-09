{ pkgs, left, down, up, right, modifier, menu, terminal, menu_run, lock, ... }:
{
  # Standart keybind
  "${modifier}+b" = "exec ${pkgs.foot}/bin/footclient -- ${pkgs.btop}/bin/btop";
  "${modifier}+Return" = "exec ${terminal}";
  "${modifier}+Shift+q" = "kill";
  "${modifier}+d" = "exec ${menu}";
  "${modifier}+Shift+d" = "exec ${menu_run}";

  "${modifier}+i" = "exec ${lock} --screenshots	--clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc --key-hl-color 880033 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --grace 2 --fade-in 0.2";

  "${modifier}+${left}" = "focus left";
  "${modifier}+${down}" = "focus down";
  "${modifier}+${up}" = "focus up";
  "${modifier}+${right}" = "focus right";

  "${modifier}+Left" = "focus left";
  "${modifier}+Down" = "focus down";
  "${modifier}+Up" = "focus up";
  "${modifier}+Right" = "focus right";

  "${modifier}+Shift+${left}" = "move left";
  "${modifier}+Shift+${down}" = "move down";
  "${modifier}+Shift+${up}" = "move up";
  "${modifier}+Shift+${right}" = "move right";

  "${modifier}+Shift+Left" = "move left";
  "${modifier}+Shift+Down" = "move down";
  "${modifier}+Shift+Up" = "move up";
  "${modifier}+Shift+Right" = "move right";

  # "${modifier}+b" = "splith";
  # "${modifier}+v" = "splitv";
  "${modifier}+f" = "fullscreen toggle";
  "${modifier}+a" = "focus parent";

  "${modifier}+s" = "layout stacking";
  "${modifier}+w" = "layout tabbed";
  "${modifier}+e" = "layout toggle split";

  "${modifier}+Shift+space" = "floating toggle";
  "${modifier}+space" = "focus mode_toggle";

  "${modifier}+1" = "workspace number 1";
  "${modifier}+2" = "workspace number 2";
  "${modifier}+3" = "workspace number 3";
  "${modifier}+4" = "workspace number 4";
  "${modifier}+5" = "workspace number 5";
  "${modifier}+6" = "workspace number 6";
  "${modifier}+7" = "workspace number 7";
  "${modifier}+8" = "workspace number 8";
  "${modifier}+9" = "workspace number 9";
  "${modifier}+0" = "workspace number 10";

  "${modifier}+Shift+1" = "move container to workspace number 1";
  "${modifier}+Shift+2" = "move container to workspace number 2";
  "${modifier}+Shift+3" = "move container to workspace number 3";
  "${modifier}+Shift+4" = "move container to workspace number 4";
  "${modifier}+Shift+5" = "move container to workspace number 5";
  "${modifier}+Shift+6" = "move container to workspace number 6";
  "${modifier}+Shift+7" = "move container to workspace number 7";
  "${modifier}+Shift+8" = "move container to workspace number 8";
  "${modifier}+Shift+9" = "move container to workspace number 9";
  "${modifier}+Shift+0" = "move container to workspace number 10";

  "${modifier}+Shift+minus" = "move scratchpad";
  "${modifier}+minus" = "scratchpad show";

  # fn keys
  "XF86AudioRaiseVolume" = "exec amixer sset Master 2%+";
  "XF86AudioLowerVolume" = "exec amixer sset Master 2%-";
  "XF86AudioMute" = "exec amixer sset Master toggle";
  "XF86MonBrightnessUp" = "exec light -A 2%";
  "XF86MonBrightnessDown" = "exec light -U 2%";


  "${modifier}+Shift+c" = "reload";
  "${modifier}+Shift+e" =
    "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

  "${modifier}+r" = "mode resize";
}
