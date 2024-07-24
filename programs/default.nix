# programs.nix for managing system programs.
{config, pkgs, ... }:

{
  # Import configurations for Apache2, MariaDB, PHP stack.
  imports = [
    ./desktop.nix           # Desktop configurations
    ./nix-ld.nix            # nix-ld configurations
    ./overrides.nix         # Override packages
    ./programs.nix          # Spesific programs
    ./services.nix          # Service configurations
    ./virtualisation.nix    # Virtualisation configurations
  ];

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
    dive
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
    podman-tui
    qemu_kvm
    rar
    tree
    usbutils
    vim
    wget
  ];

  # Add environment variables.
  environment.variables = {
    CHROME_EXECUTABLE = "google-chrome-stable";
  };

}
