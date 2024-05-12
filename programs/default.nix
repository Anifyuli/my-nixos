{ pkgs, lib, ... }: {
  imports = [
    ./services.nix
    ./server.nix
    ./desktop.nix
    ./container.nix
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    nativeMessagingHosts.packages = [pkgs.unstable.firefoxpwa];
    wrapperConfig = {
      pipewireSupport = true;
    };
  };

  # List packages installed in the system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # vim
    neovim
    # nvim-pkg
    vscode
    # neovim-maximal
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
    gcc
    unstable.firefoxpwa
    gcc

    # Unstable channel
    unstable.distrobox
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

  # Captive browser support.
  programs.captive-browser.enable = true;
  programs.captive-browser.interface = "wlp3s0";

  # Nano
  programs.nano = {
    enable = true;
    nanorc = ''
      set nowrap
      set tabstospaces
      set tabsize 2
      set linenumbers
      set autoindent
    '';
  };

  # allow unfree pkgs
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "genymotion"
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
