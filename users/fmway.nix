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
    "vboxusers"
    "fwupd-refresh"
  ];
  packages = with pkgs; [
    # cli
    element # periodic table
    clipman # clipboard manager
    matui
    # ytui-music
    
    # bui (browser user interface)
    filebrowser

    # gui
    fmpkgs.bootstrap-studio # figma alternative 
    foliate # reader for desktop
    # youtube-music
    dbeaver-bin # sql client
    element-desktop # matrix client
    fluffychat # also this
    # cinny-desktop # also this
    weechat
    zoom-us
    libreoffice-fresh
    zotero-beta
    anytype
    kdenlive
    custom.obs-studio

    # development
    # wasmer
    rust-analyzer
    clang-tools
    zls
    deno
    bun
    yarn
  ];
  shell = pkgs.fish;
}
