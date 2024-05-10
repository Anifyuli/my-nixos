# services.nix for managing services
{config, pkgs, ...}:

{
  # Apache2 server 
  services.httpd.enable = true;
  services.httpd.adminAddr = "localhost";
  services.httpd.enablePHP = true;
  services.httpd.virtualHosts."htdocs" = {
    documentRoot = "/var/www/htdocs";
  };

  # MariaDB server
  services.mysql.enable = false;
  services.mysql.package = pkgs.mariadb;

  # Enable GNOME keyring.
  services.gnome.gnome-keyring.enable = true;

  ## List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable Flatpak support
  services.flatpak.enable =  true;
  xdg.portal.enable = true;

  # Enable fwupd for updating firmware.
  services.fwupd.enable = true;

  # Enable throttled.service for fix Intel CPU throttling
  services.throttled.enable = false;
}
