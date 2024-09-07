{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dconf-editor
    gnome-tweaks
    beeper
    # session-desktop
    gnome-extension-manager
    # protonmail-desktop
    appimagekit # ..
    # popsicle # bootable creator
    vscode # 🤫
    fmpkgs.xdman # xdm download manager
    mpv # video player
    zed-editor # another text editor
    adwaita-icon-theme # ...
    google-chrome
    telegram-desktop
    discord
    # fmpkgs.stayfree-desktop
    # youtube-music # ...
    gst_all_1.gstreamer # ...
    keepassxc # password manager
    # qutebrowser
    # fmpkgs.keypunch # monkeytype for gnome
    # mako
    firefoxpwa # pwa for firefox

    # terminal
    contour
    # wezterm
  ] ++ (with gnomeExtensions; [
    paperwm
    appindicator
    clipboard-indicator
    thinkpad-battery-threshold
    blur-my-shell
    # net-speed
    totp
    cloudflare-warp-toggle
    system-monitor
    weather-oclock
  ]);
}
