{ pkgs, ... }:
{
  enable = true;
  package = pkgs.firefox;
  nativeMessagingHosts.packages = [pkgs.firefoxpwa];
  wrapperConfig = {
    pipewireSupport = true;
  };
}
