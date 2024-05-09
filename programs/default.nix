# programs.nix for managing system programs.
{config, pkgs, ... }:

{
  # Import configurations for Apache2, MariaDB, PHP stack.
  imports = [
    ./android.nix         # Android SDK
    ./lamp-stack.nix      # Lamp stack configurations
    ./container.nix       # Container configurations
    ./desktop.nix         # Desktop configurations
    ./overrides.nix       # Override packages
    ./services.nix        # Service configurations
    ./virtualbox.nix      # VirtualBox configurations
  ];

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
    inxi
    jdk
    neofetch
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
    unstable.nodePackages_latest.nodejs
  ];

  # Environment variables
  environment.variables = {
    ANDROID_HOME = /nix/var/nix/profiles/system/sw/share/android-sdk;
  };

  # Exclude packages from the X server.
  services.xserver.excludePackages = [
    pkgs.xterm
  ];
 
  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
 
  # Add GSConnect connection configuration.
  programs.kdeconnect.enable = true;
  programs.kdeconnect.package = pkgs.gnomeExtensions.gsconnect;
  
  # Captive browser support.
  programs.captive-browser.enable = true;
  programs.captive-browser.interface = "wlp59s0";

}
