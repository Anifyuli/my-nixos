# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, inputs, outputs, pkgs, nixpkgs, getDefaultNixs, ... }:
{
  imports = ((builtins.foldl' (acc: curr: [
      (lib.path.append ./. curr)
    ] ++ acc) [] (getDefaultNixs ./.)) ++ 
    [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ]);

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Overlays
  # nixpkgs.overlays = outputs.overlays;


  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # auto optimise the store
  nix.settings.auto-optimise-store = true;
  # GC
  nix.gc = {
    automatic = true;
    dates = "Mon,Fri *-*-* 00:00:00";
    options = "--delete-older-than 5d";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "unstable"; # Did you read the comment?
}
