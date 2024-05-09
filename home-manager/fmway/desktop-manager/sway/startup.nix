{ pkgs, lock, ... }:
[
  { command = "${pkgs.foot}/bin/foot --server"; }
  { command = "${pkgs.light}/bin/light -S 5%"; }
  { command = "wl-paste -t text --watch ${pkgs.clipman}/bin/clipman store --no-persist"; }
  {
    command = ''${pkgs.swayidle}/bin/swayidle -w timeout 300 '${lock} -f -c 000000' timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' before-sleep "${lock} -f -c 000000"'';
  }
]
