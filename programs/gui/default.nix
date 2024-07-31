{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # protonmail-desktop
    appimagekit # ..
    popsicle # bootable creator
    vscode # 🤫
    fmpkgs.xdman # xdm download manager
    mpv # video player
    zed-editor # another text editor
    adwaita-icon-theme # ...
    youtube-music # ...
    gst_all_1.gstreamer # ...
    keepassxc # password manager
    # qutebrowser
    fmpkgs.keypunch # monkeytype for gnome
    # mako
    firefoxpwa # pwa for firefox

    # terminal
    wezterm
    contour
  ];
}
