# programs.nix for managing system programs.
{config, pkgs, ...}:

{
  # Import configurations for Apache2, MariaDB, PHP stack.
  imports = [
    ./lamp-stack.nix    # Lamp stack configurations
    ./container.nix     # Container configurations
    ./desktop.nix       # Desktop configurations
    ./services.nix      # Service configurations
    ./virtualbox.nix    # VirtualBox configurations
  ];

  # Add the unstable channel to get the latest updates.
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };
    };
    home-manager.useUserPackages = true;
    home-manager.useGlobalPkgs = true;
  };
  
  # List packages installed in the system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Stable channel
    btop
    dive
    docker-compose
    ffmpeg-full
    fwupd
    git
    gnome.adwaita-icon-theme
    gst_all_1.gstreamer
    jdk
    neofetch
    nodejs_21
    ntfs3g
    openssl
    podman-tui
    qemu_kvm
    tree
    vim
    wget
    xorg.xhost

    # Unstable channel
    unstable.distrobox
    unstable.fzf
  ];

  # Exclude packages from the X server.
  services.xserver.excludePackages = [
    pkgs.xterm
  ];

  # Enable ADB 
  programs.adb.enable = true;

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
 
  # Add GSConnect connection configuration.
  programs.kdeconnect.enable = true;
  programs.kdeconnect.package = pkgs.gnomeExtensions.gsconnect;
}

