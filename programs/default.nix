{ pkgs, lib, genImports, ... }:
{
  imports = genImports ./.;

  # allow unfree pkgs
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "genymotion"
      "spotify"
    ];


  # List packages installed in the system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # vim
    neovim
    appimagekit
    popsicle
    speechd
    nixgl.nixGLIntel
    # nvim-pkg
    vscode
    # neovim-maximal
    custom.xdman
    qemu
    cloudflare-warp
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
    niri
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

  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox;
      nativeMessagingHosts.packages = [pkgs.firefoxpwa];
      wrapperConfig = {
        pipewireSupport = true;
      };
    };

    fish.enable = true;
    adb.enable = true; 

    # Java
    # programs.java.enable = true;

    # Steam
    steam = {
      enable = true;
      #remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      #dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      gamescopeSession.enable = true;
    };

    # Some programs need SUID wrappers, can be configured further or are started in user sessions.
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Add GSConnect connection configuration.
    kdeconnect.enable = true;
    kdeconnect.package = pkgs.gnomeExtensions.gsconnect;

    # Nano
    nano = {
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

    # nix-ld for handling dynamic lib
    # nix-ld = {
      # enable = true;
      # libraries = with pkgs; [
        # glibc
        # openssl
        # gcc.cc.lib
      # ];
    # };

    
    # NixVim
    # nixvim = {
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
  };

}
