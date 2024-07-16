{ pkgs, ... }:
{
  enable = true;
  settings =
    pkgs.stubby.passthru.settingsExample
    // {
      upstream_recursive_servers = [
        {
          address_data = "1.1.1.1";
          tls_auth_name = "cloudflare-dns.com";
          tls_pubkey_pinset = [
            {
              digest = "sha256";
              value = "HdDBgtnj07/NrKNmLCbg5rxK78ZehdHZ/Uoutx4iHzY=";
            }
          ];
        }
        {
          address_data = "1.0.0.1";
          tls_auth_name = "cloudflare-dns.com";
          tls_pubkey_pinset = [
            {
              digest = "sha256";
              value = "HdDBgtnj07/NrKNmLCbg5rxK78ZehdHZ/Uoutx4iHzY=";
            }
          ];
        }
      ];
    };
}
