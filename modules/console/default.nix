{ pkgs, ... }:

{
  # Change console/tty configurations
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";
    keyMap = "uk";
    packages = with pkgs; [ terminus_font ];
  };
}
