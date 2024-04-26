{ config, pkgs, lib, ... }:
{
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.httpd.enable = true;
  services.httpd.adminAddr = "localhost";
  services.httpd.enablePHP = true;

  services.httpd.virtualHosts."htdocs" = {
    documentRoot = "/var/www/htdocs";
  };

  services.mysql.enable = true;
  services.mysql.package = pkgs.mariadb;

}
