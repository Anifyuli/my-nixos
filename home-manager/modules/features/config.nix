{ config, pkgs, lib, ... } @ variables: let
  cfg = config.features.config;

  inherit (pkgs.functions)
    tree-path
    doImport
    ;

  inherit (builtins)
    foldl'
    ;

  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    types
    recursiveUpdate
    hasSuffix
    removeSuffix
    ;

in {
  options.features.config = {
    enable = mkEnableOption "enable config";
    cwd = mkOption {
      type = types.path;
      description = "directory configs";
      example = ''
        cwd = ./configs;
      '';
    };
    variables = mkOption {
      type = types.attrs;
      default = variables;
    };
  };
  config.xdg.configFile = mkIf cfg.enable (let
    dir = cfg.cwd;
    result = foldl' (acc: file: let
      source = dir + ("/" + file);
    in recursiveUpdate acc (if ! hasSuffix ".nix" file then {
      "${file}" = { inherit source; }; 
    } else {
      "${removeSuffix ".nix" file}" = {
        text = doImport source cfg.variables;
      };
    })) {} (tree-path { inherit dir; prefix = ""; });
  in result);
}
