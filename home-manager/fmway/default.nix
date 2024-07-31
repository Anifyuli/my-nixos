{ pkgs, genTreeImports, ... }: let
  user = "fmway";
  home = "/home/${user}";
  inherit (pkgs.functions) getEnv genPaths;
in {
  imports = [ ./desktop ] ++ genTreeImports ../modules;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    username = user;
    homeDirectory = home;

    sessionPath = genPaths home [
      ".local" # must be ${home}/.local/bin
      ".cargo" # etc
      ".deno"
      ".bun"
      ".foundry"
    ];

    sessionVariables = {
      ASSETS = "${home}/assets";
      GITHUB = "${home}/assets/Github";
      PL = "${home}/assets/pl";
      PROJECTS = "${home}/assets/Projects"; 
    } // (getEnv user);

    # Home Manager version
    stateVersion = "24.11"; 
  }; 

  # $HOME/.config refers to ./configs
  features = {
    config = {
      enable = true;
      cwd = ./configs;
    };

    # programs refers to ./programs
    programs.auto-import = {
      enable = true;
      cwd = ./programs;
      include = {
        suffixs = [ ".fish" ];
        filenames = [ "extraConfig" ];
      };
    };

    # install collection of scripts in ./scripts
    script = {
      enable = true;
      cwd = ./scripts;
    };
  };
}
