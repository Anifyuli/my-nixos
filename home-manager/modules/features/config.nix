{ lib, config, pkgs, ... } @ variables: let
  cfg = config.features.config;
  inherit (pkgs.functions) tree-path getRequiredArgs;
  inherit (builtins) foldl' isFunction;
  inherit (lib) mkIf mkEnableOption mkOption types recursiveUpdate hasSuffix removeSuffix;
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
  };
  config.xdg.configFile = mkIf cfg.enable (let
    dir = cfg.cwd;
    result = foldl' (acc: file: let
      source = dir + ("/" + file);
    in recursiveUpdate acc (if ! hasSuffix ".nix" file then {
      "${file}" = { inherit source; }; 
    } else {
      "${removeSuffix ".nix" file}" = {
        text = let
          imported = import source;
        in if isFunction imported then
          imported (getRequiredArgs imported variables)
        else
          imported;
      };
    })) {} (tree-path { inherit dir; prefix = ""; });
  in result);
}
