{ config, lib, pkgs, ... }: let

  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    mkBefore
  ;

  inherit (builtins)
    attrNames
    foldl'
  ;

  github = pkgs.fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = "firefox-gnome-theme";
    rev = "v128";
    hash = "sha256-zB+Zd0V0ayKP/zg9n1MQ8J/Znwa49adylRftxuc694k=";
  };

  cfg = config.programs.firefox;

  chromes = profile: let
    enable = cfg.profiles.${profile}.gnome-theme;
    base = ".mozilla/firefox/${profile}/chrome";
  in {
    "${base}/userChrome.css" = mkIf enable {
      text = mkBefore ''
        @import "firefox-gnome-theme/userChrome.css";
      '';
    };
    "${base}/userContent.css" = mkIf enable {
      text = mkBefore ''
        @import "firefox-gnome-theme/userContent.css";
      '';
    };
    "${base}/firefox-gnome-theme" = mkIf enable {
      source = github;
    };
    };
in {
  options.programs.firefox.profiles = mkOption {
    type = types.attrsOf (types.submodule {
      options = {
        gnome-theme = mkEnableOption "enable gnome-theme";
      };
    });
  };
  config = mkIf cfg.enable {
    home.file = foldl' (acc: curr: acc // (chromes curr)) {} (attrNames cfg.profiles);
  };
}
