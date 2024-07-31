{ config, pkgs, lib, ... } @ variables: let
  cfg = config.features.programs.auto-import;
  inherit (builtins) readDir attrNames;
  inherit (pkgs.functions) removeSuffix' excludeItems treeImport;
  inherit (lib) recursiveUpdate listToAttrs mkIf mkOption mkEnableOption types;
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
    cwd = mkOption {
      type = types.nullOr types.path;
      default = null;
    };
    excludes = mkOption {
      type = types.listOf types.str;
      default = [];
    };

    include = mkOption {
      type = types.submodule {
        options = {
          prefixs = mkOption {
            type = types.listOf types.str;
            default = [];
          };
          suffixs = mkOption {
            type = types.listOf types.str;
            default = [];
          };
          filenames = mkOption {
            type = types.listOf types.str;
            default = [];
          };
        };
      };
      default = {};
    };
  };

  config = mkIf (! isNull cfg.enable) {
    programs = recursiveUpdate (enableFeatures cfg.cwd) (treeImport {
      folder = cfg.cwd;
      depth = 0; # include top-level default.nix
      inherit variables;
      inherit (cfg) excludes include;
    });
  };
}
