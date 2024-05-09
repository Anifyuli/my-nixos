{ pkgs, ... }: let
  # create cert
  tls-cert = {  alt ? [], cname ? "localhost" }: (pkgs.runCommand "selfSignedCert" { buildInputs = [ pkgs.openssl ]; } ''
    mkdir -p $out
    openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -days 365 -nodes \
      -keyout $out/cert.key -out $out/cert.crt \
      -subj "/CN=${cname}" -addext "subjectAltName=DNS:localhost,${builtins.concatStringsSep "," (["IP:127.0.0.1"] ++ alt)}"
  '');
  # example
  # anu-cert = tls-cert { cname = "download.mikrotik.com"; alt = [ "DNS:download.mikrotik.com" ]; };
in {
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    package = pkgs.nginxStable.override {
      openssl = pkgs.libressl;
    };

    # setup virtual host
    # virtualHosts."download.mikrotik.com" = {
    #   forceSSL = true;
    #   sslCertificate = "${anu-cert}/cert.crt";
    #   sslCertificateKey = "${anu-cert}/cert.key";
    #   locations."/" = {
    #     proxyPass = "http://127.0.0.1:8080";
    #     #proxyWebsockets = true; # needed if you need to use WebSocket
    #     extraConfig =
    #       # required when the target is also TLS server with multiple hosts
    #       "proxy_ssl_server_name on;" +
    #       # required when the server wants to use HTTP Authentication
    #       "proxy_pass_header Authorization;"
    #   };
    # };
  };

  # register your ssl cert
  security.pki.certificateFiles = [
    # example
    # "${anu-cert}/cert.crt"
  ];

  #security.acme = {
    #acceptTerms = true;
    #defaults.email = "namaku1801@gmail.com";
  #};
}
