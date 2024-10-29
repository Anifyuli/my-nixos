{ pkgs, ... }:

{
  # List packages installed in the system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ 
    adwaita-icon-theme
    android-studio
    android-tools
    bindfs
    btop
    clang
    cloudflare-warp
    cmake
    distrobox_git
    docker-compose
    ffmpeg-full
    flutter
    fwupd
    git
    gst_all_1.gstreamer
    inxi
    lm_sensors
    ncdu
    ninja
    nodePackages_latest.nodejs
    ntfs3g
    openssl
    pciutils
    php
    pkg-config-unwrapped
    qemu_kvm
    rar
    smartmontools
    tree
    usbutils
    vim
    wget
  ];

  # Exclude GNOME default apps
  environment.gnome.excludePackages = with pkgs; [
    geary
  ];

  # Add environment variables.
  environment.variables = {
    CHROME_EXECUTABLE = "google-chrome-stable";
    LIBVA_DRIVER_NAME = "iHD";
  };

}
