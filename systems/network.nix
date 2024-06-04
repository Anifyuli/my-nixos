{ pkgs, ... }: {
  networking.hostName = "Namaku1801"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [80 443 51820];

  # /etc/hosts
  networking.extraHosts = ''
    127.0.0.1 fmway
    127.0.0.1 php.local.com
    127.0.0.1 cgi.local.com
    127.0.0.1 nyoba.com
    127.0.0.1 download.mikrotik.com
  '';

  networking.wireguard.enable = true;

  # Setup DNS
  networking.nameservers = ["127.0.0.1" "::1"];
  networking.networkmanager.dns = "none";

  # Make sure you don't have services.resolved.enable on.

  services.stubby = {
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
  };

  # Proxy
  # networking.proxy = {
  #   httpProxy = "http://192.168.43.1:8080";
  #   httpsProxy = "http://192.168.43.1:8080";
  #   allProxy = "http://192.168.43.1:8080";
  # };

  # Wireguard
  networking.firewall.checkReversePath = "loose";
  networking.firewall = {
    logReversePathDrops = true;
    # up
    extraCommands = ''
      ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
      ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
    '';

    # down
    extraStopCommands = ''
      ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
      ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
    '';
  };
}
