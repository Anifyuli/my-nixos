{ config, ... }:
{
  root = "/srv/cgi";
  locations."/" = {
    index = "index.cgi index.html index.htm";
  };

  locations."~ \\.cgi$". extraConfig = ''
    # rewrite ^/cgi/(.*) /$1 break;
    gzip off;

    include fastcgi_params;
    fastcgi_pass = unix:${config.services.fcgiwrap.instances.fmway.socket.address};
    fastcgi_param SCRIPT_FILENAME /srv/cgi$fastcgi_script_name;
  '';
  }
