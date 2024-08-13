{ pkgs, ... }:
{
  carapace = {
    enable = true;
    enableFishIntegration = false;
  };

  zoxide.enable = true;

  swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };
}
