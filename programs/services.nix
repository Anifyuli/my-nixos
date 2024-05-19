# services.nix for managing services
{config, pkgs, ...}:

{
  # Apache2 server 
  services.httpd = {
    enable = false;
    adminAddr = "localhost";
    enablePHP = true;
    virtualHosts."htdocs" = {
      documentRoot = "/var/www/htdocs";
    };
  };

  # MariaDB server
  services.mysql = {
    enable = false;
    package = pkgs.mariadb;
  };

  # Setup PHP FPM
  services.phpfpm.phpOptions = ''
    display_errors = on;
  '';
  
  # Enable GNOME keyring.
  services.gnome.gnome-keyring.enable = true;
  
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable Flatpak support
  services.flatpak.enable =  true;
  xdg.portal.enable = true;

  # Enable fwupd for updating firmware.
  services.fwupd.enable = true;

  # Enable throttled.service for fix Intel CPU throttling.
  services.throttled.enable = false;
}
