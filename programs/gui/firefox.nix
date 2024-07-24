{ pkgs, ... }:
{
  enable = true;
  package = pkgs.firefox;
  nativeMessagingHosts.packages = with pkgs; [
    firefoxpwa
  ];
  wrapperConfig = {
    pipewireSupport = true;
  };
}
