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
  programs = {
    # firefox
    firefox = {
      enable = true;
      package = pkgs.firefox;
      nativeMessagingHosts.packages = [pkgs.firefoxpwa];
      wrapperConfig = {
        pipewireSupport = true;
      };
    };

    # Steam
    steam = {
      enable = true;
      #remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      #dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      gamescopeSession.enable = true;
    };

  };

}
