{ pkgs, lib, extra, ... }: let
  inherit (extra) lock;
in [
  { command = "${lib.getExe pkgs.foot} --server"; }
  { command = "${lib.getExe pkgs.light} -S 5%"; }
  { command = ''wl-paste -t text --watch "${lib.getExe pkgs.clipman} store --no-persist"''; }
  { command = "systemctl --user import-environment XDG_CURRENT_DESKTOP XDG_SESSION_TYPE"; }
  { command = "dbus-update-activation-environment WAYLAND_DISPLAY"; }
  {
    command = ''${lib.getExe pkgs.swayidle} w timeout 300 '${lock} -f -c 000000' timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' before-sleep "${lock} -f -c 000000"'';
  }
]
