# network.nix for network system stuff
{config, pkgs, ...}:

{
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Firewall 
  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPortRanges = [
      {
        from = 40000;
        to = 50000;
      }
      {
        from = 50001;
        to = 65535;
      }
    ];
  };

  # DBus controll interface for NetworkManager
  networking.wireless.dbusControlled = true;

  # Change hostname 
  networking.hostName = "ThinkPad-X280";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-fortisslvpn
      networkmanager-iodine
      networkmanager-l2tp
      networkmanager-openconnect
      networkmanager-openvpn
      networkmanager-vpnc
      networkmanager-sstp
    ];
  };

}
