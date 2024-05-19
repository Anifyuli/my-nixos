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
    mongodb-compass
    nodePackages_latest.pnpm
  ];

  # Alacritty
  programs.alacritty= { 
    enable = true;
    settings = {};
  };

  # Bash configurations.
  programs.bash = {
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
  home.stateVersion = "24.05";  
  };

}
