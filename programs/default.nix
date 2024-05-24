# programs.nix for managing system programs.
{config, pkgs, ... }:

{
  # Import configurations for Apache2, MariaDB, PHP stack.
  imports = [
    ./android.nix           # Android SDK
    ./desktop.nix           # Desktop configurations
    ./overrides.nix         # Override packages
    ./services.nix          # Service configurations
    ./virtualization.nix    # Virtualization configurations
  ];

  # List packages installed in the system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    btop
    dive
    docker-compose
    distrobox
    ffmpeg-full
    fwupd
    git
    gnome.adwaita-icon-theme
    gst_all_1.gstreamer
    inxi
    jdk17
    nodePackages_latest.nodejs
    ntfs3g
    openssl
    php
    podman-tui
    qemu_kvm
    rar
    tree
    vim
    wget
  ];

  # Add environment variables.
  environment.variables = {
    CHROME_EXECUTABLE = "google-chrome-stable";
  };

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
