{ pkgs, ... }:
{
  enable = true;
  nativeMessagingHosts = with pkgs ;[
    firefoxpwa
    gnome-browser-connector
  ];
}
