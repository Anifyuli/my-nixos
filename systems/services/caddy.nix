{ config, pkgs, ... }: let
  printPath = x: let
    user = config.users.users.${x};
    home-manager = config.home-manager.users.${x};
    toString = arr: builtins.concatStringsSep ":" arr;
  in toString (
    # home-manager level
    home-manager.home.sessionPath ++ [ 
      "${user.home}/.local/share/flatpak/exports" # flatpak
      "/var/lib/flatpak/exports" # flatpak
      "${user.home}/.nix-profile/bin" # profile level
      "/etc/profiles/per-user/${user.name}/bin" # user level
      "/run/current-system/sw/bin" # system level
    ]);
in {
  enable = true;
  virtualHosts."http://cgi.local.com".extraConfig = ''
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
