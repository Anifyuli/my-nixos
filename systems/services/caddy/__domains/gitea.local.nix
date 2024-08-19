{ config, ... }: let
  inherit (config.services) certs;
in {
  type = "https";
  extraConfig = ''
    tls ${certs.gitea.cert} ${certs.gitea.key}
    log {
      format console
      output stdout
    }
    reverse_proxy localhost:3000
  '';
}
