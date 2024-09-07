{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    appimagekit
    popsicle
    vscode
    custom.xdman
    zed-editor
    gnome.adwaita-icon-theme
    gst_all_1.gstreamer
    keepassxc
    qutebrowser
    custom.keypunch
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
