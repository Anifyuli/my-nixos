{ pkgs }:
{
  # Add Android additional udev rules.
  packages = with pkgs; [
    android-udev-rules
    gnome-settings-daemon
  ];
}