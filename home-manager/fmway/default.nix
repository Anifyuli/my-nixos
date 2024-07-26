{ pkgs
, lib
, basename
, customImport
, treeImport
, genTreeImports
, genDefaultImports
, genImports
, config
, nixosConfig
, inputs
, ... } @ variables : let
  user = "fmway";
  home = "/home/${user}";
in treeImport {
  folder = ./.;
  variables = variables // {
    inherit user home;
  };
  excludes = [ "configs" "desktop" ];
  # depth = 2; # ./1/2
} {
  imports = [ ./desktop ] ++ genTreeImports ../modules [ ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home = {
    username = user;
    homeDirectory = home;

    # Home Manager version
    stateVersion = "24.11"; 
  }; 

  # $HOME/.config refers to ./configs
  features.config = {
    enable = true;
    cwd = ./configs;
  };
}
