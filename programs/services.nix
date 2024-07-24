# services.nix for managing services
{config, pkgs, ...}:

{
  # Apache2 server.
  services.httpd = {
    enable = true;
    adminAddr = "localhost";
    enablePHP = true;
    group = "users";
    phpPackage = pkgs.php;
    phpOptions = ''
      date.timezone = "Asia/Jakarta";
      display_errors = on;
      upload_max_filesize = "100M";
      post_max_size = "100M";
    '';
    user = "anifyuli";
    virtualHosts."htdocs" = {
      documentRoot = "/home/anifyuli/Developments/Web/htdocs";
      locations."/".index = "index.php index.html";
    };
  };

  # MariaDB server.
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  # PostgreSQL server.
  services.postgresql = {
    enable = false;
    package = pkgs.postgresql_15;
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

  # Enable touchegg for X11 gesture support.
  services.touchegg.enable = true;

  # Enable fwupd for updating firmware.
  services.fwupd.enable = true;

  # Enable thermald for CPU temperature auto handling.
  services.thermald.enable = true;

  # Enable throttled.service for fix Intel CPU throttling.
  services.throttled.enable = false;

  # Enable systemd services which is not configured from services options
  systemd = {
    packages = with pkgs; [
      cloudflare-warp
    ];
    targets.multi-user.wants = [
      "warp-svc.service"
    ];
  };

}
