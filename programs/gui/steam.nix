{ pkgs, ... }:
{
  enable = false;
  #remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  #dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  gamescopeSession.enable = true;
  protontricks.enable = true;
  # extraPackages = with pkgs; [
  # ];
}
