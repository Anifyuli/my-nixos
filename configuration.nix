## configuration.nix
{ config, pkgs, ... }:

{
  imports =
    [ # NixOS hardware 
      <nixos-hardware/lenovo/thinkpad/x280>
      
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
       
      # Programs configurations.
      ./programs/programs.nix
      
      # System configurations.
      ./systems/systems.nix
      
      # Users configurations & user-installed packages.
      ./users/users.nix

      # Home Manager.
      ./home-manager/home-manager.nix
    ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # NixOS version, change it if latest update released
  system.stateVersion = "23.11";

}
