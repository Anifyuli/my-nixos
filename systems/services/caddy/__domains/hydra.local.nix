{ config, ... }: let
  inherit (config.services) certs hydra;
in {
  type = "https";
  enable = hydra.enable;
  extraConfig = ''
    tls ${certs.hydra.cert} ${certs.hydra.key}
    log {
      format console
      output stdout
    }
    reverse_proxy localhost:${toString hydra.port}
  '';
}
