{ config, ... }: let
  inherit (config.services) certs gitea;
in {
  type = "https";
  extraConfig = ''
    tls ${certs.gitea.cert} ${certs.gitea.key}
    log {
      format console
      output stdout
    }
    reverse_proxy localhost:${toString gitea.settings.server.HTTP_PORT}
  '';
}
