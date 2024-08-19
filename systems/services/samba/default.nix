{ pkgs, ... }:
{
  enable = true;
  package = pkgs.sambaFull;
  securityType = "user";
  openFirewall = true;
}
