{ pkgs, ... }: {
  hostName = "Namaku1801"; # Define your hostname.
  hostId = "4970ef8d"; # required for zfs
  # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # proxy.default = "http://user:password@proxy:port/";
  # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networkmanager.enable = true;
  networkmanager.wifi.powersave = true;

  # /etc/hosts
  hosts = {
    "127.0.0.1" = [
      "fmway"
      "php.local.com"
      "gitea.local"
      "cgi.local.com"
      "nyoba.com"
      "hydra.local"
      # "download.mikrotik.com"
    ];
  };

  # Open ports in the firewall.
  # firewall.allowedTCPPorts = [ ... ];
  # firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # firewall.enable = false;
  firewall.allowedTCPPorts = [
    80
    5900
    9000
    3000
    3001
    8080
    8000
    8888
    9876
    1234
    443
    445
    51820
  ];

  firewall.allowedUDPPortRanges = [
    # winbox problem
    {
      from = 40000;
      to = 50000;
    }
  ];

  # firewall.allowedTCPPortsRanges = [
  #   { from = 8000; to = 9999; }
  # ];
  # firewall.allowPing = true;

  # wireguard
  wireguard.enable = true;

  # Setup DNS
  nameservers = ["127.0.0.1" "::1"];
  networkmanager.dns = "none";


  # Proxy
  # proxy = {
  #   httpProxy = "http://192.168.43.1:8080";
  #   httpsProxy = "http://192.168.43.1:8080";
  #   allProxy = "http://192.168.43.1:8080";
  # };
  # resolvconf.enable = false;

  # handling Wireguard to firewall
  # firewall = {
  #   checkReversePath = "loose";
  #   # if packets are still dropped, they will show up in dmesg
  #   logReversePathDrops = true;
  #   # up
  #   extraCommands = ''
  #     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
  #     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
  #   '';
  #
  #   # down
  #   extraStopCommands = ''
  #     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
  #     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
  #   '';
  # };
}
