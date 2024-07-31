{ pkgs, ... }: {
  hostName = "Namaku1801"; # Define your hostname.
  # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # proxy.default = "http://user:password@proxy:port/";
  # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networkmanager.enable = true;

  # Open ports in the firewall.
  # firewall.allowedTCPPorts = [ ... ];
  # firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # firewall.enable = false;
  firewall.allowedTCPPorts = [80 5900 9000 3000 8080 8000 8888 9876 1234 443 445 51820];
  firewall.allowPing = true;

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

  # register Wireguard to firewall
  firewall = {
    checkReversePath = "loose";
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
