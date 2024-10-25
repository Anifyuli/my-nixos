{ config, pkgs, ... }:
{
  enable = ! config.services.caddy.enable;
  recommendedProxySettings = true;
  recommendedTlsSettings = true;
  package = pkgs.nginxStable.override {
    openssl = pkgs.libressl;
  };
}
