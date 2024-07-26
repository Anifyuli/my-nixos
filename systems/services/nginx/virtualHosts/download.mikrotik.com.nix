{ config, pkgs, ... }:
{
  forceSSL = true;
  sslCertificate = "${config.certs.anu}/cert.crt";
  sslCertificateKey = "${config.certs.anu}/cert.key";
  locations."/" = {
    proxyPass = "http://127.0.0.1:8080";
    #proxyWebsockets = true; # needed if you need to use WebSocket
    extraConfig = ''
      # required when the target is also TLS server with multiple hosts
      "proxy_ssl_server_name on;" +
      # required when the server wants to use HTTP Authentication
      "proxy_pass_header Authorization;"
    '';
  };
}
