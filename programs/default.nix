{ pkgs, lib, ... }:
{
  imports = [
    ./services.nix
    ./server.nix
    ./desktop.nix
    ./overlays.nix
    ./container.nix
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    nativeMessagingHosts.packages = [pkgs.firefoxpwa];
    wrapperConfig = {
      pipewireSupport = true;
    };
  };

  # List packages installed in the system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # vim
    neovim
    popsicle
    nixgl.nixGLIntel
    # nvim-pkg
    vscode
    # neovim-maximal
    custom.xdman
    qemu
    # qemu with efi 
    (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
      qemu-system-x86_64 \
        -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
        "$@"
    '')
    quickemu
    wget
    doas
    starship
    zip
    unzip
    ffmpeg-full
    fwupd
    gnome.adwaita-icon-theme
    gst_all_1.gstreamer
    podman-tui
    tree
    xorg.xhost
    keepassxc
    docker-compose
    btop
    mako
    firefoxpwa

    distrobox
  ];

  # Exclude packages from the X server.
  services.xserver.excludePackages = [
    pkgs.xterm
  ];

  programs.fish.enable = true;
  programs.adb.enable = true; 

  # Java
  programs.java.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    #remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    #dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  # programs.steam.package = pkgs.steam-small.override {
  # withPrimus = true;
  # extraPkgs = pkgs: [ bumblebee glxinfo ];
  # withJava = true;
  # };
  programs.steam.gamescopeSession.enable = true;

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Add GSConnect connection configuration.
  programs.kdeconnect.enable = true;
  programs.kdeconnect.package = pkgs.gnomeExtensions.gsconnect;

  # Nano
  programs.nano = {
    enable = true;
    nanorc = ''
      set nowrap
      set tabstospaces
      set tabsize 2
      set linenumbers
      set autoindent
      set mouse
    '';
  };

  # allow unfree pkgs
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "genymotion"
      "spotify"
    ];

  # NixVim
  # programs.nixvim = {
  #   enable = true;
  #   colorschemes.gruvbox.enable = true;
  #   plugins.lightline.enable = true;
  #   extraPlugins = with pkgs.vimPlugins; [
  #     vim-nix
  #   ];

  #   opts = {
  #     number = true;
  #     relativenumber = true;
  #     shiftwidth = 2;
  #   };

  #   keymaps = [
  #     {
  #       key = ";";
  #       action = ":";
  #     }
  #     {
  #       mode = "n";
  #       key = "<leader>m";
  #       options.silent = true;
  #       action = "<cmd>!make<CR>";
  #     }
  #   ];
  # };
}
