{ config, ... }:
{
  root = "/srv/php";
  # locations."/" = {
    # index = "index.php index.html index.html";
  # };
  locations."~ \\.php$".extraConfig = ''
    fastcgi_pass unix:${config.services.phpfpm.pools.mypool.socket};
    fastcgi_index index.php
  '';
  }
