{ lib, config, pkgs, ... }: let
  inherit (lib)
    mkAfter
    mkIf
    mkOption
    types
    ;

  inherit (builtins)
    foldl'
    attrNames
    length
    ;

  env = { ... } @ obj:
    foldl' (acc: curr:
      acc + "export ${curr}\n"
    ) "" (lib.mapAttrsToList (key: value: "${key}=${toString value}") obj);

  cfg = config.wayland.windowManager.sway.my.env;

in {
  options.wayland.windowManager.sway.my.env = mkOption {
    type = types.attrsOf (types.nullOr (types.oneOf (with types; [
      int
      str
      bool
      path
    ])));
    default = {};
  };
  config.wayland.windowManager.sway = mkIf (length (attrNames cfg) != 0) {
    extraSessionCommands = mkAfter (env cfg);
  };
}
