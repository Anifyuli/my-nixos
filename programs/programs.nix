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
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  # Appimage support & enable binfmt.
  programs.appimage = {
    binfmt = true;
    enable = true;
  };

  # GNOME Evolution
  programs.evolution = {
    enable = true;
    plugins = with pkgs; [
      evolution-ews
    ];
  };
  
  # Captive browser support.
  programs.captive-browser = {
    enable = true;
    interface = "wlp59s0";
  };

  # Enable ls colors in Bash
  programs.bash.enableLsColors = true;

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
  };

}
