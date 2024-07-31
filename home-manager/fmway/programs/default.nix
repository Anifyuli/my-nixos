{ pkgs, ... }:
{
  carapace = {
    enable = true;
    enableFishIntegration = false;
  };

  swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };
}
