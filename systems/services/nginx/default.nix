{ config, pkgs }:
{
  enable = true;
  recommendedProxySettings = true;
  recommendedTlsSettings = true;
  package = pkgs.nginxStable.override {
    openssl = pkgs.libressl;
  };

}
