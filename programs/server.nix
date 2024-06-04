{ pkgs, config, ... }: let
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

  # services.nginx = {
  #   enable = true;
  #   recommendedProxySettings = true;
  #   recommendedTlsSettings = true;
  #   package = pkgs.nginxStable.override {
  #     openssl = pkgs.libressl;
  #   };
  #
  #   virtualHosts."cgi.local.com" = {
  #     root = "/srv/cgi";
  #     locations."/" = {
  #       index = "index.cgi index.html index.htm";
  #     };
  #
  #     locations."~ \\.cgi$". extraConfig = ''
  #       # rewrite ^/cgi/(.*) /$1 break;
  #       gzip off;
  #
  #       include fastcgi_params;
  #       fastcgi_pass = unix:${config.services.fcgiwrap.socketAddress};
  #       fastcgi_param SCRIPT_FILENAME /srv/cgi$fastcgi_script_name;
  #     '';
  #   };

    # virtualHosts."php.local.com" = {
    #   root = "/srv/php";
    #   # locations."/" = {
    #     # index = "index.php index.html index.html";
    #   # };
    #   locations."~ \\.php$".extraConfig = ''
    #     fastcgi_pass unix:${config.services.phpfpm.pools.mypool.socket};
    #     fastcgi_index index.php
    #   '';
    # };

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
  # };

  # register your ssl cert
  security.pki.certificateFiles = [
    # example
    # "${anu-cert}/cert.crt"
  ];

  #security.acme = {
    #acceptTerms = true;
    #defaults.email = "namaku1801@gmail.com";
  #};

  # caddy server
  services.caddy = {
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
        reverse_proxy unix/${config.services.fcgiwrap.socketAddress} {
          transport fastcgi {
            env PATH /run/current-system/sw/bin
            split .cgi
          }
        }
      }
    '';
  };

  services.fcgiwrap = {
    enable = true;
    group = config.services.nginx.user;
  };
  # services.phpfpm.pools.mypool = {
  #   user = "nobody";
  #   settings = {
  #     "pm" = "dynamic";
  #     "listen.owner" = config.services.nginx.user;
  #     "pm.max_children" = 5;
  #     "pm.start_server" = 2;
  #     "pm.min_spare_servers" = 1;
  #     "pm.max_spare_servers" = 3;
  #     "pm.max_requests" = 500;
  #   };
  # };
  #
}
