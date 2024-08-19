{ pkgs, ... }:
{
  enable = false;
  package = pkgs.sambaFull;
  securityType = "user";
  openFirewall = true;
}
