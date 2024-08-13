{ pkgs, ... }:
{
  cloudflare-warp.enable = true;
  cloudflare-warp.package = pkgs.custom.cloudflare-warp;
  # Enable GNOME keyring.
  gnome.gnome-keyring.enable = true;

  # emulate /bin
  envfs.enable = true;

  # Enable Flatpak support
  flatpak.enable = true;

  # Enable fprintd and python-validity
  # open-fprintd.enable = true;
  # python-validity.enable = true;

  # Enable fwupd for updating firmware.
  fwupd.enable = true;

  openssh.enable = true;

  # gesture moments 😱
  # touchegg.enable = true; # nope, i use wayland

  samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  samba = {
    enable = true;
    package = pkgs.sambaFull;
    securityType = "user";
    openFirewall = true;
  };

  # Enale throttled.service for fix Intel CPU throttling
  # throttled.enable = false;

  # add fingerprint to sudo
  # pam.services.sudo.fprintAuth = true;
  # pam.services.login.fprintAuth = true;
}
