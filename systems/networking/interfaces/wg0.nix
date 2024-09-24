{ config, pkgs, lib, ... }: let
  iptables = lib.getExe' pkgs.iptables "iptables";
  outInterface = config.networking.nat.externalInterface;
in {
   # Determines the IP address and subnet of the server's end of the tunnel interface.
  ips = [ "10.100.0.1/24" ];

  # The port that WireGuard listens to. Must be accessible by the client.
  listenPort = 51820;

  # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
  # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
  postSetup = ''
    ${iptables} -t nat -A POSTROUTING -s 10.100.0.0/24 -o ${outInterface} -j MASQUERADE
  '';

  # This undoes the above command
  postShutdown = ''
    ${iptables} -t nat -D POSTROUTING -s 10.100.0.0/24 -o ${outInterface} -j MASQUERADE
  '';

  # Path to the private key file.
  #
  # Note: The private key can also be included inline via the privateKey option,
  # but this makes the private key world-readable; thus, using privateKeyFile is
  # recommended.
  privateKeyFile = config.age.secrets.wg0-private.path;

  peers = [
    # List of allowed peers.
    { # Feel free to give a meaning full name
      # Public key of the peer (not a file path).
      publicKey = "MyTJb9uK2LsFZlmNha6ZUvb3l1UZ73vTOQE1VipPrCk=";
      # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
      allowedIPs = [ "10.100.0.2/32" ];
    }
  ];
}
