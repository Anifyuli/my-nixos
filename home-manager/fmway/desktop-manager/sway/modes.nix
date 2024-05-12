{ modifier, mode, left, up, right, down, ... }: let
  commands = {
    ex-default = "swaymsg mode default";
  };
in {
  resize = {
    "${left}" = "resize shrink width 10 px";
    "${down}" = "resize grow height 10 px";
    "${up}" = "resize shrink height 10 px";
    "${right}" = "resize grow width 10 px";
    "Left" = "resize shrink width 10 px";
    "Down" = "resize grow height 10 px";
    "Up" = "resize shrink height 10 px";
    "Right" = "resize grow width 10 px";
    "Escape" = "mode default";
    "Return" = "mode default";
  };
  "${mode.workspace}" = {
    "1" = "exec ${commands.ex-default} && swaymsg workspace number 1";
    "${modifier}+1" = "exec ${commands.ex-default} && swaymsg workspace number 1";
    "2" = "exec ${commands.ex-default} && swaymsg workspace number 2";
    "${modifier}+2" = "exec ${commands.ex-default} && swaymsg workspace number 2";
    "3" = "exec ${commands.ex-default} && swaymsg workspace number 3";
    "${modifier}+3" = "exec ${commands.ex-default} && swaymsg workspace number 3";
    "4" = "exec ${commands.ex-default} && swaymsg workspace number 4";
    "${modifier}+4" = "exec ${commands.ex-default} && swaymsg workspace number 4";
    "5" = "exec ${commands.ex-default} && swaymsg workspace number 5";
    "${modifier}+5" = "exec ${commands.ex-default} && swaymsg workspace number 5";
    "6" = "exec ${commands.ex-default} && swaymsg workspace number 6";
    "${modifier}+6" = "exec ${commands.ex-default} && swaymsg workspace number 6";
    "7" = "exec ${commands.ex-default} && swaymsg workspace number 7";
    "${modifier}+7" = "exec ${commands.ex-default} && swaymsg workspace number 7";
    "8" = "exec ${commands.ex-default} && swaymsg workspace number 8";
    "${modifier}+8" = "exec ${commands.ex-default} && swaymsg workspace number 8";
    "9" = "exec ${commands.ex-default} && swaymsg workspace number 9";
    "${modifier}+9" = "exec ${commands.ex-default} && swaymsg workspace number 9";
    "0" = "exec ${commands.ex-default} && swaymsg workspace number 10";
    "${modifier}+0" = "exec ${commands.ex-default} && swaymsg workspace number 10";

    "Shift+1" = "exec ${commands.ex-default} && swaymsg workspace number 11";
    "${modifier}+Shift+1" = "exec ${commands.ex-default} && swaymsg workspace number 11";
    "Shift+2" = "exec ${commands.ex-default} && swaymsg workspace number 12";
    "${modifier}+Shift+2" = "exec ${commands.ex-default} && swaymsg workspace number 12";
    "Shift+3" = "exec ${commands.ex-default} && swaymsg workspace number 13";
    "${modifier}+Shift+3" = "exec ${commands.ex-default} && swaymsg workspace number 13";
    "Shift+4" = "exec ${commands.ex-default} && swaymsg workspace number 14";
    "${modifier}+Shift+4" = "exec ${commands.ex-default} && swaymsg workspace number 14";
    "Shift+5" = "exec ${commands.ex-default} && swaymsg workspace number 15";
    "${modifier}+Shift+5" = "exec ${commands.ex-default} && swaymsg workspace number 15";
    "Shift+6" = "exec ${commands.ex-default} && swaymsg workspace number 16";
    "${modifier}+Shift+6" = "exec ${commands.ex-default} && swaymsg workspace number 16";
    "Shift+7" = "exec ${commands.ex-default} && swaymsg workspace number 17";
    "${modifier}+Shift+7" = "exec ${commands.ex-default} && swaymsg workspace number 17";
    "Shift+8" = "exec ${commands.ex-default} && swaymsg workspace number 18";
    "${modifier}+Shift+8" = "exec ${commands.ex-default} && swaymsg workspace number 18";
    "Shift+9" = "exec ${commands.ex-default} && swaymsg workspace number 19";
    "${modifier}+Shift+9" = "exec ${commands.ex-default} && swaymsg workspace number 19";
    "Shift+0" = "exec ${commands.ex-default} && swaymsg workspace number 20";
    "${modifier}+Shift+0" = "exec ${commands.ex-default} && swaymsg workspace number 20";

    "Return" = ''mode "default"'';
    "Escape" = ''mode "default"'';
  };
}
