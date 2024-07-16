{ config, pkgs, ... }:
{
  enable = true;
  recommendedProxySettings = true;
  recommendedTlsSettings = true;
  package = pkgs.nginxStable.override {
    openssl = pkgs.libressl;
  };

  virtualHosts."cgi.local.com" = {
    root = "/srv/cgi";
    locations."/" = {
      index = "index.cgi index.html index.htm";
    };

    locations."~ \\.cgi$". extraConfig = ''
      # rewrite ^/cgi/(.*) /$1 break;
      gzip off;

      include fastcgi_params;
      fastcgi_pass = unix:${config.services.fcgiwrap.fmway.socket.address};
      fastcgi_param SCRIPT_FILENAME /srv/cgi$fastcgi_script_name;
    '';
  };

  virtualHosts."php.local.com" = {
    root = "/srv/php";
    # locations."/" = {
      # index = "index.php index.html index.html";
    # };
    locations."~ \\.php$".extraConfig = ''
      fastcgi_pass unix:${config.services.phpfpm.pools.mypool.socket};
      fastcgi_index index.php
    '';
  };

  # setup virtual host
  virtualHosts."download.mikrotik.com" = {
    forceSSL = true;
    sslCertificate = "${pkgs.certs.anu-cert}/cert.crt";
    sslCertificateKey = "${pkgs.certs.anu-cert}/cert.key";
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
  };
}
