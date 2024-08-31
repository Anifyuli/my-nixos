{ pkgs, config, ... }: let
in {
  # Determines the IP/IPv6 address and subnet of the client's end of the tunnel interface
  address = [ "10.0.0.2/24" "fd4:8e3:226:2e0::2/64" ];
  # The port that WireGuard listens to - recommended that this be changed from default
  listenPort = 51820;
  # Path to the server's private key
  privateKeyFile = config.age.secrets.wg-private.path;
  
  peers = [
    { # peer0
      publicKey = "ymW2avJDHa4G6I18GeAl6HS80SZgXWEWtjwX5/0nvw4=";
      # presharedKeyFile = "/root/wireguard-keys/preshared_from_peer0_key";
      allowedIPs = [ "0.0.0.0/0" "::/0" ];
      endpoint = "192.168.43.1:51820";
      persistentKeepalive = 25;
    }
    # More peers can be added here.
  ];
}
