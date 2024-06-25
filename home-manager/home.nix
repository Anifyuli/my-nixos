## Home Manager as NixOS module
{ config, pkgs, ... }:

{
  home-manager.users.anifyuli = { pkgs, ... }: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "anifyuli";
  home.homeDirectory = "/home/anifyuli";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    alacritty-theme
    exercism
    gnomeExtensions.cloudflare-warp-toggle
    gnomeExtensions.x11-gestures
    mongodb-compass
    pnpm
    postman
  ];
  
  # Alacritty
  programs.alacritty= { 
    enable = true;
    settings = {};
  };

  # Bash configurations.
  programs.bash = {
    enable = true;
    enableVteIntegration = true;
    historyControl = [
      "ignoreboth"
      "erasedups"
    ];
    historyIgnore = [
      "?"
      "??"
    ];
    historyFile = "~/.bash_history";
    shellOptions = [
      "autocd"
      "cdspell"
      "direxpand"
      "dirspell" 
      "globstar" 
      "histappend" 
      "histverify"
      "nocaseglob" 
      "no_empty_cmd_completion"
    ];
    bashrcExtra = "
      source ~/.bash/themes/aphrodite/aphrodite.theme.sh # Use Aphrodite prompt theme
    ";
  };
 
  # Golang configurations.
  programs.go = {
    enable = true;
    goBin = ".go/bin";
    goPath = ".go";
  };
  
  # Vim configurations.
  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vim;
    defaultEditor = true;
    settings = {
      expandtab = true;
      mouse = "a";
      number = true;
      shiftwidth = 2;
      tabstop = 2;
    };
    extraConfig = ''
      set softtabstop=2
      set smartindent
    '';
  };

  # Home Manager version
  home.stateVersion = "24.11";  
  };

}
