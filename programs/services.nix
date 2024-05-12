{ pkgs, ...}: {
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

  # Enale throttled.service for fix Intel CPU throttling
  # services.throttled.enable = false;

  # Cloudflared tunnel
  users.users.cloudflared = {
    group = "cloudflared";
    isSystemUser = true;
  };

  users.groups.cloudflared = { };

  # Systemd for cloudflared tunnel
  systemd.services.cloudflared = {
    description = "Cloudflare Tunnel";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      EnvironmentFile = "/etc/secrets/cloudflared.env";
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token \${TOKEN}";
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };
}
