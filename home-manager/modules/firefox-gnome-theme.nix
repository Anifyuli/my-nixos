{ config, lib, pkgs, ... }: let

  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    mkBefore
  ;

  inherit (builtins)
    listToAttrs
    attrNames
    map
    filter
    foldl'
  ;

  github = pkgs.fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = "firefox-gnome-theme";
    rev = "v128";
    hash = "sha256-zB+Zd0V0ayKP/zg9n1MQ8J/Znwa49adylRftxuc694k=";
  };
in {
  options.programs.firefox.profiles = mkOption {
    type = types.attrsOf (types.submodule {
      options = {
        gnome-theme = mkEnableOption "enable gnome-theme";
      };
    });
  };
  config = let
    inherit (config.programs.firefox) profiles;
    enable =
      if isNull (filter (x: profiles.${x}.gnome-theme) (attrNames profiles)) then
        false
      else
        true;
  in mkIf enable (let
    chromes = foldl' (acc: curr: acc // {
      ".mozilla/firefox/${curr}/chrome/userChrome.css".text = mkBefore ''
        @import "firefox-gnome-theme/userChrome.css";
      '';
      ".mozilla/firefox/${curr}/chrome/userContent.css".text = mkBefore ''
        @import "firefox-gnome-theme/userContent.css";
      '';
    }) {} (attrNames profiles);
    dot = map (x: {
      name = ".mozilla/firefox/${x}/chrome/firefox-gnome-theme";
      value = {
        source = github;
      };
    }) (attrNames profiles);
  in {
    home.file = (listToAttrs dot) // chromes;
  });
}
