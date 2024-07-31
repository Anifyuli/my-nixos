{ pkgs, ... }:
{
  isNormalUser = true;
  description = "fmway";
  home = "/home/fmway";
  extraGroups = [
    "networkmanager" 
    "docker" 
    "wheel"
    "video"
    "gdm"
    "dialout"
    "kvm"
    "adbusers"
  ];
  packages = with pkgs; [
    fmpkgs.bootstrap-studio
    fmpkgs.popsql
    gnome-extension-manager
    dconf-editor
    gnome-tweaks
    foliate
    # youtube-music
    google-chrome
    dbeaver-bin
    zoom-us
    discord
    telegram-desktop
    libreoffice-fresh
    zotero-beta
    anytype
    kdenlive
    rustup
    zls
    zig
    deno
    bun
    custom.obs-studio
    fmpkgs.cargo-tauri
    fmpkgs.cargo-create-tauri-app
    trunk
    yarn
    clipman
    nodejs
    wasmer
    filebrowser
    nodejs
    # nixpacks
    ytui-music
    dejavu_fonts
  ] ++ (with gnomeExtensions; [
    paperwm
    appindicator
    clipboard-indicator
    thinkpad-battery-threshold
    blur-my-shell
    net-speed
    totp
    cloudflare-warp-toggle
    system-monitor
    weather-oclock
  ]);
  shell = pkgs.fish;
}
