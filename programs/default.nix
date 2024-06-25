# programs.nix for managing system programs.
{config, pkgs, ... }:

{
  # Import configurations for Apache2, MariaDB, PHP stack.
  imports = [
    ./desktop.nix           # Desktop configurations
    ./nix-ld.nix            # nix-ld configurations
    ./overrides.nix         # Override packages
    ./services.nix          # Service configurations
    ./virtualization.nix    # Virtualization configurations
  ];

  # List packages installed in the system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ 
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
    gnome.adwaita-icon-theme
    gst_all_1.gstreamer
    inxi
    jdk17
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
