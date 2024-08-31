{ pkgs
, pam-fingerprint
, lib
, config
, ...
}
:
{
  cloudflare-warp.enable = true;
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
    enable = config.services.samba.enable;
    openFirewall = true;
  };

  zfs.autoScrub.enable = true;
  # zfs.trim.enable = false;

  # Enale throttled.service for fix Intel CPU throttling
  # throttled.enable = false;

}
