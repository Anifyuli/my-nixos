{ pkgs, ... }:
{
  # Add GSConnect connection configuration.
  enable = true;
  package = pkgs.gnomeExtensions.gsconnect;
}
