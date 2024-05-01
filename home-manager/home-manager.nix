## Home Manager as NixOS module
{ config, pkgs, ... }:

{
  imports = [
    # Add Home Manager as NixOS module
    <home-manager/nixos> 
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  home-manager.users.anifyuli = { pkgs, ... }: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "anifyuli";
  home.homeDirectory = "/home/anifyuli";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # Stable channel
    flutter-unwrapped
    nodePackages_latest.pnpm
  ];

  # Bash configurations.
  programs.bash = {
    historyFile = "~/.bash_history";
  };

  # Fzf configurations.
  programs.fzf.enableBashIntegration = true;

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
  home.stateVersion = "23.11";  
  };

}
