{ pkgs, ... }: let
  inherit (builtins)
    attrNames
  ;
  dns = {
    "1.1.1.1" = {
      tls_auth_name = "cloudflare-dns.com";
      signedCert = [
        "4pqQ+yl3lAtRvKdoCCUR8iDmA53I+cJ7orgBLiF08kQ="
      ];
    };
    "1.0.0.1" = {
      inherit (dns."1.1.1.1") tls_auth_name signedCert;
    };
  };
in {
  enable = true;
  settings =
    pkgs.stubby.passthru.settingsExample //
    {
      upstream_recursive_servers = map (x: {
        inherit (dns.${x}) tls_auth_name;
        address_data = x;
        tls_pubkey_pinset = map (value: {
          inherit value;
          digest = "sha256";
        }) dns.${x}.signedCert;
      }) (attrNames dns);
    };
}
