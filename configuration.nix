{ ... }:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Overlays
  # nixpkgs.overlays = outputs.overlays;


  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = ["root" "fmway"];
  };

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
  system.stateVersion = "24.11"; # Did you read the comment?
}
