{ pkgs, extra, ... }: let
  inherit (extra) lock;
  com = pkg: str: "${pkgs.${pkg}}/bin/${pkg} ${str}";
in [
  { command = com "foot" "--server"; }
  { command = com "light" "-S 5%"; }
  { command = ''wl-paste -t text --watch ${com "clipman" "store --no-persist"}''; }
  { command = "systemctl --user import-environment XDG_CURRENT_DESKTOP XDG_SESSION_TYPE"; }
  { command = "dbus-update-activation-environment WAYLAND_DISPLAY"; }
  {
    command = com "swayidle" ''w timeout 300 '${lock} -f -c 000000' timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' before-sleep "${lock} -f -c 000000"'';
  }
]
