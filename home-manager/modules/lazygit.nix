{ lib
, config
, pkgs
# , excludeItems
, ... }: let
  inherit (lib)
    mkIf
    mkOption
    types
    mkAfter
    flatten
    last
    splitString
  ;
  
  inherit (builtins)
    map
    isNull
    head
    readDir
    attrNames
    filter
  ;

  inherit (pkgs)
    fetchFromGitHub
  ;

  inherit (pkgs.functions)
    parser
    removeSuffix'
    hasSuffix'
  ;

  list-theme = attrNames (readDir "${src}/themes");
  list-color = theme: let 
    list = attrNames (readDir "${src}/themes/${theme}");
    filtered = filter (x: hasSuffix' ".yml" x) list;
  in map (x: removeSuffix' ".yml" x) filtered;

  themes = flatten (map (x:
    map (y:
      "${x}-${y}"
    ) (list-color x)
  ) list-theme);
  
  # settings = (excludeItems [ "gui" ] cfg.settings) // (if cfg.settings ? gui then {
  #   gui = excludeItems [ "theme" ] cfg.settings.gui;
  # } else {});

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "lazygit";
    rev = "v2.2.0";
    hash = "sha256-mHB4Db71uKblCDab47eBIKd63ekYjvXOqUkY/ELMDQQ=";
  };

  cfg = config.programs.lazygit;
in {
  options.programs.lazygit = {
    theme = mkOption {
      type = types.nullOr (types.enum themes);
      default = null;
    };
  };
  config = mkIf cfg.enable {
    programs.lazygit.settings = mkIf (! isNull cfg.theme) (let
      selector = splitString "-" cfg.theme;
      inherit (parser.readYAML "${src}/themes/${head selector}/${last selector}.yml") theme;
    in mkAfter {
      gui = { inherit theme; };
    });
  };
}
