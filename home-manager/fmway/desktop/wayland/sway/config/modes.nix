{ extra, command, ... }: let
  inherit (extra) mod mode left up right down;
  inherit (command) resize mode-default ex-default swaymsg to-workspace;
in {
  resize = {
    "${left}" = resize.left 10;
    "${down}" = resize.down 10;
    "${up}" = resize.up 10;
    "${right}" = resize.right 10;
    "Left" = resize.left 10;
    "Down" = resize.down 10;
    "Up" = resize.up 10;
    "Right" = resize.right 10;
    "Escape" = mode-default;
    "Return" = mode-default;
  };
  "${mode.workspace}" = {
    "1" = ex-default (swaymsg (to-workspace 1));
    "${mod}+1" = ex-default (swaymsg (to-workspace 1));
    "2" = ex-default (swaymsg (to-workspace 2));
    "${mod}+2" = ex-default (swaymsg (to-workspace 2));
    "3" = ex-default (swaymsg (to-workspace 3));
    "${mod}+3" = ex-default (swaymsg (to-workspace 3));
    "4" = ex-default (swaymsg (to-workspace 4));
    "${mod}+4" = ex-default (swaymsg (to-workspace 4));
    "5" = ex-default (swaymsg (to-workspace 5));
    "${mod}+5" = ex-default (swaymsg (to-workspace 5));
    "6" = ex-default (swaymsg (to-workspace 6));
    "${mod}+6" = ex-default (swaymsg (to-workspace 6));
    "7" = ex-default (swaymsg (to-workspace 7));
    "${mod}+7" = ex-default (swaymsg (to-workspace 7));
    "8" = ex-default (swaymsg (to-workspace 8));
    "${mod}+8" = ex-default (swaymsg (to-workspace 8));
    "9" = ex-default (swaymsg (to-workspace 9));
    "${mod}+9" = ex-default (swaymsg (to-workspace 9));
    "0" = ex-default (swaymsg (to-workspace 10));
    "${mod}+0" = ex-default (swaymsg (to-workspace 10));

    "Shift+1" = ex-default (swaymsg (to-workspace 11));
    "${mod}+Shift+1" = ex-default (swaymsg (to-workspace 11));
    "Shift+2" = ex-default (swaymsg (to-workspace 12));
    "${mod}+Shift+2" = ex-default (swaymsg (to-workspace 12));
    "Shift+3" = ex-default (swaymsg (to-workspace 13));
    "${mod}+Shift+3" = ex-default (swaymsg (to-workspace 13));
    "Shift+4" = ex-default (swaymsg (to-workspace 14));
    "${mod}+Shift+4" = ex-default (swaymsg (to-workspace 14));
    "Shift+5" = ex-default (swaymsg (to-workspace 15));
    "${mod}+Shift+5" = ex-default (swaymsg (to-workspace 15));
    "Shift+6" = ex-default (swaymsg (to-workspace 16));
    "${mod}+Shift+6" = ex-default (swaymsg (to-workspace 16));
    "Shift+7" = ex-default (swaymsg (to-workspace 17));
    "${mod}+Shift+7" = ex-default (swaymsg (to-workspace 17));
    "Shift+8" = ex-default (swaymsg (to-workspace 18));
    "${mod}+Shift+8" = ex-default (swaymsg (to-workspace 18));
    "Shift+9" = ex-default (swaymsg (to-workspace 19));
    "${mod}+Shift+9" = ex-default (swaymsg (to-workspace 19));
    "Shift+0" = ex-default (swaymsg (to-workspace 20));
    "${mod}+Shift+0" = ex-default (swaymsg (to-workspace 20));

    "Return" = mode-default;
    "Escape" = mode-default;
  };
}
