{config, pkgs, ...}:

{
  # Some programs need SUID wrappers, can be configured further or are started in user sessions
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable ls colors in Bash
  programs.bash.enableLsColors = true;
 
  # Add GSConnect connection configuration
  programs.kdeconnect.enable = true;
  programs.kdeconnect.package = pkgs.gnomeExtensions.gsconnect;
  
  # Captive browser support
  programs.captive-browser.enable = true;
  programs.captive-browser.interface = "wlp59s0";

  # Java configs
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  # Enable nix-ld
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    chromium
    cups
    curl
    dbus
    expat
    fontconfig
    freetype
    fuse3
    gdk-pixbuf
    glib
    gtk3
    icu
    libGL
    libappindicator-gtk3
    libdrm
    libglvnd
    libnotify
    libpng
    libpulseaudio
    libunwind
    libusb1
    libuuid
    libxkbcommon
    libxml2
    mesa
    nspr
    nss
    openssl
    pango
    pipewire
    stdenv.cc.cc
    systemd
    vulkan-loader
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxcb
    xorg.libxkbfile
    xorg.libxshmfence
    xwayland
    zlib
  ];

  # Noisetorch installation
  programs.noisetorch.enable = true;

  # Winbox setup
  programs.winbox = {
    enable = true;
    openFirewall = true;
    package = pkgs.winbox;
  };
  
  # Add XWayland 
  programs.xwayland.enable = true;
}
