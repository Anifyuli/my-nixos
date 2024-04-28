# network.nix for network system stuff
{config, pkgs, ...}:

{

  networking.hostName = "ThinkPad-X280"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  
  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = false; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings = {
	  General = {
		  Experimental = true;
	  };
  };
  hardware.bluetooth.input = {
    General = {
      ClassicBondedOnly = true;
      IdleTimeout = 30;
    };  
  };

}
