{ config, pkgs, lib, matchers, ... } @ variables: let
  cfg = config.features.programs.auto-import;

  inherit (builtins)
    readDir
    attrNames
    ;

  inherit (pkgs.functions)
    removeExtension
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
    dirs = attrNames (excludeItems [ ".alias.nix" ".var.nix" "default.nix" ] (readDir cwd)); 
  in listToAttrs (map (x: let
    exts = matchers.getExt (cfg.includes ++ [ matchers.nix ]); 
  in {
    name = removeExtension exts x;
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

  config = mkIf cfg.enable {
    programs = let
      result = treeImport {
        folder = cfg.cwd;
        depth = 0; # include top-level default.nix
        inherit variables;
        inherit (cfg) excludes includes;
      };
    in
      if cfg.auto-enable then
        recursiveUpdate (enableFeatures cfg.cwd) result
      else result;
  };
}
