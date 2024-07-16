{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # protonmail-desktop
    appimagekit
    popsicle
    wezterm
    vscode
    fmpkgs.xdman
    mpv
    zed-editor
    adwaita-icon-theme
    youtube-music
    gst_all_1.gstreamer
    keepassxc
    # qutebrowser
    fmpkgs.keypunch
    mako
    firefoxpwa
  ];
}
