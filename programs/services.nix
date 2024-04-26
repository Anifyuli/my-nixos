# services.nix for managing services
{config, pkgs, ...}:

{

  # Enable GNOME keyring.
  services.gnome.gnome-keyring.enable = true;

  ## List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable Flatpak support
  services.flatpak.enable =  true;
  xdg.portal.enable = true;

  # Add Android additional udev rules.
  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  # Enable fwupd for updating firmware.
  services.fwupd.enable = true;
}
