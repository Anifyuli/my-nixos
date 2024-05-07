{
  services,
  xdg,
  pkgs,
  ...
}: {
  # Enable GNOME keyring.
  services.gnome.gnome-keyring.enable = true;

  # emulate /bin
  services.envfs.enable = true;

  ## List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    # settings.PasswordAuthentication = false;
    # settings.KbdInteractiveAuthentication = false;
    #settings.PermitRootLogin = "yes";
  };
  # Enable Flatpak support
  services.flatpak.enable = true;

  # portal with wayland support
  xdg.portal = {
    enable = true;
    # extraPortals = with pkgs; [
      # xdg-desktop-portal-wlr
    #  xdg-desktop-portal-gtk
    #];
  };

  # Add Android additional udev rules.
  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  # Enable fwupd for updating firmware.
  services.fwupd.enable = true;
}
