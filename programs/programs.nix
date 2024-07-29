# programs.nix for handling spesific programs
{config, pkgs, ...}:

{

  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
 
  # Add GSConnect connection configuration.
  programs.kdeconnect.enable = true;
  programs.kdeconnect.package = pkgs.gnomeExtensions.gsconnect;
  
  # Captive browser support.
  programs.captive-browser.enable = true;
  programs.captive-browser.interface = "wlp59s0";

  # Java configs.
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  # Noisetorch installation
  programs.noisetorch.enable = true;

  # Winbox setup.
  programs.winbox = {
    enable = true;
    openFirewall = true;
    package = pkgs.winbox.override {
      wine = pkgs.wineWowPackages.stagingFull;
    };
  };
}
