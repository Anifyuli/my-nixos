{ config, pkgs, ... }:

{
  # List packages installed in the system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ 
    adwaita-icon-theme
    android-studio
    android-tools
    btop
    clang
    cloudflare-warp
    cmake
    desktop-file-utils
    docker-compose
    distrobox
    ffmpeg-full
    flutter
    fwupd
    git
    gst_all_1.gstreamer
    gtop
    inxi
    ninja
    nodePackages_latest.nodejs
    ntfs3g
    openssl
    pciutils
    php
    pkg-config-unwrapped
    qemu_kvm
    rar
    tree
    usbutils
    vim
    wget
  ];

  # Add environment variables.
  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD";
    CHROME_EXECUTABLE = "google-chrome-stable";
  };

}
