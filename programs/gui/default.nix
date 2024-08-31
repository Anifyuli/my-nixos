{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dconf-editor
    gnome-tweaks
    # gdm-settings
    # session-desktop
    gnome-extension-manager
    # protonmail-desktop
    appimagekit # ..
    # popsicle # bootable creator
    vscode # 🤫
    fmpkgs.xdman # xdm download manager
    mpv # video player
    # zed-editor # another text editor
    adwaita-icon-theme # ...
    # google-chrome
    # youtube-music # ...
    gst_all_1.gstreamer # ...
    keepassxc # password manager
    # qutebrowser
    # fmpkgs.keypunch # monkeytype for gnome
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

  programs.winbox = {
    enable = true;
    openFirewall = true;
  };
}
