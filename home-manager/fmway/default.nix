{ pkgs
, matchers
, lib
# , genTreeImports
, parseFish
, ... } @ variables: let
  inherit (pkgs.functions) getEnv genPaths;
in {
  imports = [ ./desktop ];

  programs.home-manager.enable = true;
  home = rec {
    username = "fmway";
    homeDirectory = "/home/${username}";

    # Home Manager version
    stateVersion = "24.11";

    sessionPath = genPaths homeDirectory [
      ".local" # must be ${home}/.local/bin
      ".cargo" # etc
      ".deno"
      ".bun"
      ".foundry"
    ];

    sessionVariables = {
      ASSETS = "${homeDirectory}/assets";
      GITHUB = "${homeDirectory}/assets/Github";
      DOWNLOADS = "${homeDirectory}/Downloads";
    } // (getEnv username);
  };

  # nix.extraOptions = ''
    # extra-experimental-features = nix-command flakes
  # '';

  features = {
    # $HOME/.config refers to ./configs
    config.enable = true;
    config.cwd = ./configs;

    programs.auto-import = {
      enable = true;
      cwd = ./programs;
      auto-enable = true;
      includes = let
        inherit (matchers) extension jsonc;
      in [
        (extension "fish" {
          read = path: _: parseFish (lib.fileContents path);
        })
        (extension "css")
        (extension "conf")
        (extension "tmux")
        jsonc
      ];
    };

    # install collection of scripts in ./scripts
    script.enable = true;
    script.cwd = ./scripts;
  };
}
