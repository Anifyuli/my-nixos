{ pkgs, ... }:
{
  nativeMessagingHosts = with pkgs ;[
    firefoxpwa
    gnome-browser-connector
  ];
}
