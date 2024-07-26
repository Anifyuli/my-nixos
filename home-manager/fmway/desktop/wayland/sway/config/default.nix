{ pkgs, ...}:
{
  terminal = "${pkgs.foot}/bin/footclient";
  left = "h";
  down = "j";
  up = "k";
  right = "l";
  modifier = "Mod4";
  window = {
    titlebar = false;
  };
}
