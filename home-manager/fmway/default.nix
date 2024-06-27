{ pkgs, programs, lib, ... }: let
  getDefaultNixs = folder: lib.mapAttrsToList (name: value: "${name}") (lib.filterAttrs (key: value: value == "directory" && lib.pathExists (lib.path.append folder "${key}/default.nix")) (builtins.readDir folder));
  user = "fmway";
  home = "/home/${user}";
in {

  imports = builtins.foldl' (acc: curr: [
    (lib.path.append ./. curr)
  ] ++ acc) [] (getDefaultNixs ./.);

  home = {
    username = user;
    homeDirectory = home;

    sessionVariables = {
      GITHUB = "${home}/assets/Github";
      PL = "${home}/assets/pl";
      PROJECTS = "${home}/assets/Projects"; 
    } // (pkgs.getEnv "fmway");

    sessionPath = pkgs.genPaths home [
      ".local" # must be ${home}/.local/bin
      ".cargo" # etc
      ".deno"
      ".bun"
      ".foundry"
    ];

    # packages
    packages = with pkgs; [
      custom.cargo-tauri
      gh
      fastfetch
      lazygit
      zellij
      grim
      slurp
      wl-clipboard
      dejavu_fonts
    ];
    # Home Manager version
    stateVersion = "24.11"; 
  };

  programs = let
    folder = ./.;
    list = pkgs.getNixs folder;
  in lib.lists.foldl (acc: curr: {
    "${pkgs.basename curr}" = import (lib.path.append folder curr) { inherit pkgs; };
    } // acc
  ) {} list // {

    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    # Git
    git = {
      enable = true;
      userName = "fmway";
      userEmail = "fm18lv@gmail.com";
      aliases = {
        a = "add";
        cm = "commit";
        ch = "checkout";
        s = "status";
      };
      extraConfig = {
        hub.protocol = "ssh";
        credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
      };
    };

    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
    };

    # Direnv
    direnv = {
      enable = true;
      # enableFishIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
      stdlib = ''
        session_name() {
          export TMUX_SESSION_NAME="''${*:?session_name needs a name as argument}"
        }
      '';
    };

    # Fish
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        starship init fish | source
        direnv hook fish | source
        printf '\e[5 q'
      '';
    };

    # Carapace
    carapace = {
      enable = true;
      enableFishIntegration = false;
    };

  };
}
