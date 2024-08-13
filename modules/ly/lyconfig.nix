{ save ? false, extraConfig ? "", tty, ... }:
''
# As these settings cannot be patched, we will set them as default
xsessions = /etc/ly/xsessions
waylandsessions = /etc/ly/wayland-sessions
wayland_cmd = /etc/ly/wsetup.sh
mcookie_cmd = /etc/ly/bin/mcookie
# An empty path variable will prevent ly from setting it
path =
# We will rely on the save_file
save = true
save_file = /etc/ly/ly-prefs 
load = ${
  if save
  then "true"
  else "false"
}
tty = ${toString tty}
x_cmd = /etc/ly/bin/xserver-wrapper
x_cmd_setup = /etc/ly/xsetup.sh 
xauth_cmd = /etc/ly/bin/xauth

shutdown_cmd = systemctl poweroff
term_reset_cmd = tput reset
# Terminal restore cursor command
term_restore_cursor_cmd = tput cnorm

animate = true
animation = 0

vi_mode = true


${extraConfig}
''
