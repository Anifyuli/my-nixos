{ command, extra, ... }: let
  inherit (extra)
    left
    down
    up
    right
    mod
    menu
    terminal
    menu_run
    mode
    brightnessctl
    ;
  inherit (command)
    exec
    focus
    move
    split
    layout
    to-workspace
    to-mode
    move-to-workspace
    toggle
    reload
    show
    ;
in {
  # Standart keybind
  "${mod}+Return" = exec terminal;
  "${mod}+Shift+q" = "kill";
  "${mod}+d" = exec menu;
  "${mod}+Shift+d" = exec menu_run;

  "${mod}+i" = exec "delock --ignore-empty-password --show-failed-attempts";
  "${mod}+Shift+b" = toggle.border;
 
# Moving around
  # Move your focus around
  "${mod}+${left}" = focus.left;
  "${mod}+${down}" = focus.down;
  "${mod}+${up}" = focus.up;
  "${mod}+${right}" = focus.right;
  # Or use $mod+[up|down|left|right]
  "${mod}+Left" = focus.left;
  "${mod}+Down" = focus.down;
  "${mod}+Up" = focus.up;
  "${mod}+Right" = focus.right;

  # Move the focused window with the same, but add Shift
  "${mod}+Shift+${left}" = move.left;
  "${mod}+Shift+${down}" = move.down;
  "${mod}+Shift+${up}" = move.up;
  "${mod}+Shift+${right}" = move.right;
  # Ditto, with arrow keys
  "${mod}+Shift+Left" = move.left;
  "${mod}+Shift+Down" = move.down;
  "${mod}+Shift+Up" = move.up;
  "${mod}+Shift+Right" = move.right;

# Workspace
  # Switch to workspace
  "${mod}+1" = to-workspace 1;
  "${mod}+2" = to-workspace 2;
  "${mod}+3" = to-workspace 3;
  "${mod}+4" = to-workspace 4;
  "${mod}+5" = to-workspace 5;
  "${mod}+6" = to-workspace 6;
  "${mod}+7" = to-workspace 7;
  "${mod}+8" = to-workspace 8;
  "${mod}+9" = to-workspace 9;

  # Move focused container to workspace
  "${mod}+Shift+1" = move-to-workspace 1;
  "${mod}+Shift+2" = move-to-workspace 2;
  "${mod}+Shift+3" = move-to-workspace 3;
  "${mod}+Shift+4" = move-to-workspace 4;
  "${mod}+Shift+5" = move-to-workspace 5;
  "${mod}+Shift+6" = move-to-workspace 6;
  "${mod}+Shift+7" = move-to-workspace 7;
  "${mod}+Shift+8" = move-to-workspace 8;
  "${mod}+Shift+9" = move-to-workspace 9;

# Layout stuffs
  # You can "split" the current object of your focus with
  # $mod+b or $mod+v, for horizontal and vertical splits
  # respectively.
  "${mod}+b" = split.horizontal;
  "${mod}+v" = split.vertical;

  # Switch the current container between different layout styles
  "${mod}+s" = layout.stacking;
  "${mod}+w" = layout.tabbed;
  "${mod}+e" = layout."toggle split";

  # Make the current focus fullscreen
  "${mod}+f" = toggle.fullscreen;

  # Toggle the current focus between tiling and floating mode
  "${mod}+Shift+space" = toggle.floating;

  # Swap focus between the tiling area and the floating area
  "${mod}+space" = focus.mode_toggle;

  # Move focus to the parent container
  "${mod}+a" = focus.parent;

# Scratchpad
  # Sway has a "scratchpad", which is a bag of holding for windows.
  # You can send windows there and get them back later.

  # Move the currently focused window to the scratchpad
  "${mod}+Shift+minus" = move.scratchpad;

  # Show the next scratchpad window or hide the focused scratchpad window.
  # If there are multiple scratchpad windows, this command cycles through them.
  "${mod}+minus" = show.scratchpad;

  # fn keys
  "XF86AudioRaiseVolume" = exec "amixer sset Master 2%+";
  "XF86AudioLowerVolume" = exec "amixer sset Master 2%-";
  "XF86AudioMute" = exec "amixer sset Master toggle";
  "XF86MonBrightnessUp" = exec "${brightnessctl} s +2%";
  "XF86MonBrightnessDown" = exec "${brightnessctl} s 2%-";

  # reload configuration
  "${mod}+Shift+r" = reload;

  # Exit sway (logs you out of your Wayland session)
  "${mod}+Shift+e" =
    exec "swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

  "${mod}+r" = to-mode "resize";

  "${mod}+Shift+p" = to-mode mode.workspace;
}
