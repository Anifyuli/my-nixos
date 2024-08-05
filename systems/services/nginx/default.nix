{ config, super, pkgs }:
{
  enable = ! super.caddy.enable;
  recommendedProxySettings = true;
  recommendedTlsSettings = true;
  package = pkgs.nginxStable.override {
    openssl = pkgs.libressl;
  };
}
