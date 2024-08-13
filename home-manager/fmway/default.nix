{ genTreeImports
, matchers
, lib
, pkgs
, ... } @ variables: let
  user = "fmway";
  home = "/home/${user}";
  inherit (pkgs.functions) getEnv genPaths;
in {
  imports = [ ./desktop ] ++
    genTreeImports ../modules; # my modules

  programs.home-manager.enable = true;
  home = {
    username = user;
    homeDirectory = home;

    # Home Manager version
    stateVersion = "24.11";

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
      DOWNLOADS = "${home}/Downloads";
    } // (getEnv user);
  };

  # nix.extraOptions = ''
    # extra-experimental-features = nix-command flakes
  # '';

  features = {
    # $HOME/.config refers to ./configs
    config = {
      enable = true;
      cwd = ./configs;
    };

    programs.auto-import = {
      enable = true;
      cwd = ./programs;
      auto-enable = true;
      includes = let
        inherit (matchers) extension;
        inherit (pkgs.functions) parseFish;
        inherit (lib) fileContents;
      in [
        (extension "fish" {
          read = path: variables: parseFish (fileContents path);
        })
        (extension "css")
        (extension "conf")
      ];
    };

    # install collection of scripts in ./scripts
    script = {
      enable = true;
      cwd = ./scripts;
    };
  };
}
