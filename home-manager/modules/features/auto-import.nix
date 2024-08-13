{ config, pkgs, lib, ... } @ variables: let
  cfg = config.features.programs.auto-import;

  inherit (builtins)
    readDir
    attrNames
    ;

  inherit (pkgs.functions)
    removeSuffix'
    excludeItems
    treeImport
    ;

  inherit (lib)
    recursiveUpdate
    listToAttrs
    mkIf
    mkOption
    mkEnableOption
    types
    ;

  enableFeatures = cwd: let
    dirs = attrNames (excludeItems [ "default.nix" ] (readDir cwd)); 
  in listToAttrs (map (x: {
    name = removeSuffix' ".nix" x;
    value = {
      enable = true;
    };
  }) dirs);

in {
  options.features.programs.auto-import = {
    enable = mkEnableOption "enable auto import";
    auto-enable = mkEnableOption "auto enable programs";
    cwd = mkOption {
      type = types.nullOr types.path;
      default = null;
    };
    excludes = mkOption {
      type = types.listOf types.str;
      default = [];
    };

    includes = mkOption {
      type = types.listOf types.attrs;
      default = [];
    };
  };

  config = mkIf (! isNull cfg.enable) {
    programs = let
      result = treeImport {
        folder = cfg.cwd;
        depth = 0; # include top-level default.nix
        inherit variables;
        inherit (cfg) excludes includes;
      };
    in if cfg.auto-enable then recursiveUpdate (enableFeatures cfg.cwd) result else result;
  };
}
