# programs.nix for handling spesific programs
{config, pkgs, ...}:

{ 
  # Exclude packages from the X server.
  services.xserver.excludePackages = [
    pkgs.xterm
  ];

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
}
