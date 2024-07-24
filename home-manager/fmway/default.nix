{ pkgs
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
  inherit (builtins) foldl';
in treeImport {
  folder = ./.;
  variables = variables // {
    inherit user home;
  };
  excludes = [ "configs" "desktop" ];
  depth = 2; # ./1/2

  initial = {
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
    xdg.configFile = foldl' (acc: curr: {
      "${curr}".source = ./configs + ("/" + curr); 
    } // acc ) {} (pkgs.tree-path { dir = ./configs; prefix = ""; });

    # $HOME/.config refers to github:fmway/fmconfigs/all
    # xdg.configFile = let
    #   src = pkgs.fetchFromGitHub {
    #     owner = "fmway";
    #     repo = "fmconfigs";
    #     rev = "all";
    #     hash = "sha256-0rEQ28mtX1+W5Nt+tQZXMf9cHgx7vo0no2hxj1UJ9To=";
    #   };
    # in builtins.foldl' (acc: curr: {
    #     "${curr}".source = src + ("/" + curr); 
    # } // acc ) {} (pkgs.tree-path { dir = src; prefix = ""; });

  };
}
