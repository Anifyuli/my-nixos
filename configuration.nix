## configuration.nix
{ config, pkgs, ... }:

{
  imports =
    [       
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
       
      # Programs configurations.
      ./programs
      
      # System configurations.
      ./systems
      
      # Users configurations & user-installed packages.
      ./users
    ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Change nix.conf value
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  
  # Home Manager configurations.
  home-manager.backupFileExtension = "backup";

  # NixOS version, change it if latest update released
  system.stateVersion = "unstable";

}
