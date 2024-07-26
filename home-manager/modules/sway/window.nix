{ lib, config, pkgs, ... }: let
  inherit (lib) mkAfter mkIf mkOption types flatten recursiveUpdate;
  inherit (builtins) any foldl' attrNames length concatStringsSep;
  cfg = config.wayland.windowManager.sway.my.window;
in {
  options.wayland.windowManager.sway.my.window = foldl' (acc: feature: recursiveUpdate acc {
    simple-window.${feature} = foldl' (acc2: selection: recursiveUpdate acc2 {
      "${selection}" = mkOption {
        type = types.listOf types.str;
        description = "${feature} feature by ${selection}";
        default = [];
      };
    }) {} [ "app_id" "class" "title" ];
  }) {} [ "fullscreen" "floating" ]; # feature
  config.wayland.windowManager.sway = let
    isEnabled = any (feature:
      any (selection:
        length cfg.simple-window.${feature}.${selection} != 0
      ) (attrNames cfg.simple-window.${feature})
    ) (attrNames cfg.simple-window);
  in mkIf isEnabled {
    config.window.commands = let
      result = flatten (map (feature:
        map (selection:
          map (item: {
            criteria.${selection} = item;
            command = "${feature} enable";
          }) cfg.simple-window.${feature}.${selection}
        ) (attrNames cfg.simple-window.${feature})
      ) (attrNames cfg.simple-window));
    in mkAfter result;
  };
}
