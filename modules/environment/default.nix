{ pkgs, ... }:

{
  # List packages installed in the system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ 
    #android-studio
    #android-tools
    bindfs
    btop
    #clang
    cloudflare-warp
    #cmake
    distrobox_git
    #docker-compose
    ffmpeg-full
    #flutter
    git
    gst_all_1.gstreamer
    inxi
    kdePackages.kaccounts-providers
    kdePackages.kaccounts-integration
    kdePackages.kcmutils
    kdePackages.signond
    lm_sensors
    ncdu
    #ninja
    nodePackages_latest.nodejs
    openssl
    pciutils
    #php
    #pkg-config-unwrapped
    #qemu_kvm
    libsForQt5.qoauth
    rar
    smartmontools
    tree
    usbutils
    vim
    wget
  ];

  # Add environment variables.
  environment.variables = {
    CHROME_EXECUTABLE = "google-chrome-stable";
    LIBVA_DRIVER_NAME = "iHD";
  };

}
