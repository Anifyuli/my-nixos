{ pkgs, inputs, ...}: {

  services = {
    # btrfs
    btrfs = {
      autoScrub = {
        enable = true;
        interval = "weekly";
        fileSystems = [
          "/"
          "/home/fmway"
        ];
      };
    };

    # Enable GNOME keyring.
    gnome.gnome-keyring.enable = true;

    # emulate /bin
    envfs.enable = true;

    ## List services that you want to enable:
    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      # require public key authentication for better security
      # settings.PasswordAuthentication = false;
      # settings.KbdInteractiveAuthentication = false;
      #settings.PermitRootLogin = "yes";
    };
    # Enable Flatpak support
    flatpak.enable = true;

    # Add Android additional udev rules.
    udev.packages = with pkgs; [
      android-udev-rules
    ];

    # Enable fprintd and python-validity
    # open-fprintd.enable = true;
    # python-validity.enable = true;

    # add fingerprint to sudo
    # pam.services.sudo.fprintAuth = true;
    # pam.services.login.fprintAuth = true;
    # pam.services.sudo.fprintAuth = true;


    # Enable fwupd for updating firmware.
    fwupd.enable = true;

    # Enale throttled.service for fix Intel CPU throttling
    # throttled.enable = false;
  };

  # portal with wayland support
  xdg.portal = {
    enable = true;
    # extraPortals = with pkgs; [
      # xdg-desktop-portal-wlr
    #  xdg-desktop-portal-gtk
    #];
  };
}
