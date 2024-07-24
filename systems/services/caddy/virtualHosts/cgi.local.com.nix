{ config, pkgs, ... }: let 
  printPath = pkgs.printPath;
in {
  extraConfig = ''
    log {
      format console
      output stdout
    }
    header {
      Access-Control-Allow-Headers *
      Access-Control-Allow-Methods *
      Access-Control-Allow-Origin *
    }
    @options {
      method OPTIONS
    }
    respond @options 204
    handle_path /static/* {
      root * /srv/static
      file_server
    }
    handle {
      root * /srv/cgi
      try_files {path} {path}/index.cgi {path}/index {path}.cgi
      reverse_proxy unix/${config.services.fcgiwrap.fmway.socket.address} {
        transport fastcgi {
          env PATH ${printPath "fmway"}
          split .cgi
        }
      }
    }
  '';
}
