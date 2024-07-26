{ lib, config, pkgs, ... }: let
  inherit (lib) mkIf mkEnableOption flatten mkOption reverseList strings mkAfter types;
  inherit (pkgs.functions) stringMultiply;
  inherit (builtins) foldl' isString hasAttr concatStringsSep isAttrs isBool isList listToAttrs pathExists elem head attrNames readDir;
  primitip = with types; [ int str bool ];
  primitiveType = types.oneOf primitip;
  kdlType = types.oneOf [
    primitiveType
    (types.listOf (
      types.oneOf [
        primitiveType
        (types.attrsOf primitiveType)
      ]
    ))
    (types.attrsOf kdlType)
  ];

  parse-startup = list: let
    cmd = "spawn-at-startup";
  in foldl' (acc: curr: acc + "${cmd} ${strings.toJSON curr.command}\n") "" list;

  toKV = obj: let
    names = attrNames obj;
  in concatStringsSep " " (map (key: "${key}=${strings.toJSON obj.${key}}") names);

  simple-parse = name: obj: { avoid-boolean ? false, spaces ? 0, recursive ? false, ... }: let
    names = attrNames obj;
    space = stringMultiply " " spaces;
    first = "${space}${name} {\n";
    last = "${space}}\n";
    result = foldl' (acc: name: let
      value = obj.${name};
    in acc +
      (if isBool value && avoid-boolean then 
        if value then "${space}  ${name}\n" else ""
      else if isAttrs value && recursive then
        simple-parse name value { inherit recursive avoid-boolean; spaces = spaces + 2; }
      else if isList value then
        (foldl' (acc: curr: "${acc} " + (
          if isAttrs curr then
            toKV curr
          else
            strings.toJSON curr)
        ) "${space}  ${name}" (reverseList value)) + "\n"
      else
        "${space}  ${name} ${strings.toJSON value}\n")) "" names;
  in first + result + last;
  parse-bind = obj: let
    keys = attrNames obj;
    result = map (key: let
      value = obj.${key};
    in concatStringsSep " " (flatten [ "  " key (if value ? option && ! isNull value.option then
      (toKV value.option)
    else []) "{" (if isList value.command then 
      map (x: if x == (head value.command) then
        x
      else strings.toJSON x) value.command
    else value.command) "; }"])) keys;
  in "binds {\n" + (concatStringsSep "\n" result) + "\n}\n"; 
  parse-output = obj: let
    names = attrNames obj;
    result = map (key:
      simple-parse ''output "${key}"'' obj.${key}  { 
        avoid-boolean = true;
        recursive = true;
      }
    ) names;
  in (concatStringsSep "\n" result) + "\n";
  cfg = config.wayland.windowManager.niri;
  do = { config, extraConfig, ... }:
    (if isNull config.startup then
      "" else parse-startup config.startup) +
    (if isNull config.environment then
      "" else simple-parse "environment" config.environment {}) +
    (if isNull config.input then
      "" else simple-parse "input" config.input { avoid-boolean = true; recursive = true; }) +
    (if isNull config.output then
      "" else parse-output config.output) +
    (if isNull config.output then
      "" else simple-parse "hotkey-overlay" config.hotkey { avoid-boolean = true; }) +
    (if isNull config.window then 
      "" else simple-parse "window-rule" config.window {}) +
    (if isNull config.cursor then
      "" else simple-parse "cursor" config.cursor {}) +
    (if isNull config.bind then
      "" else parse-bind config.bind) +
    (if isNull config.layout then
      "" else simple-parse "layout" config.layout { avoid-boolean = true; recursive = true; }) +
    (if config.prefer-no-csd then
      "prefer-no-csd\n" else "") +
    (if isNull config.screenshot-path then
      "" else "screenshot-path ${strings.toJSON config.screenshot-path}\n") +
    (if isNull extraConfig then
      "" else extraConfig + "\n");
in {
  options.wayland.windowManager.niri = {
    enable = mkEnableOption "enable niri";
    package = mkOption {
      type = types.package;
      default = pkgs.niri;
    };
    extraConfig = mkOption {
      type = types.nullOr types.str;
      default = null;
    };
    config = mkOption {
      type = types.nullOr (types.submodule {
        options = {
          prefer-no-csd = mkEnableOption "prefer-no-csd";
          screenshot-path = mkOption { type = types.nullOr types.str; default = null; };
          startup = mkOption {
            type = types.nullOr (types.listOf (types.submodule {
              options = {
                command = mkOption {
                  type = types.str;
                };
              };
            }));
            example = ''
            startup = [{ command = "footserver"; } { command = "waybar"; }];
            '';
            default = null;
          };
          hotkey = mkOption {
            type = types.nullOr (types.attrsOf primitiveType);
            example = ''
            hotkey = {
              skip-at-startup = true;
            '';
            default = null;
          };
          environment = mkOption {
            type = types.nullOr (types.attrsOf primitiveType);
            example = ''
            environment = {
               QT_QPA_PLATFORM = "wayland";
            };
            '';
            default = null;
          };
          cursor = mkOption {
            type = types.nullOr (types.attrsOf primitiveType);
            example = ''
            cursor = {
               xcursor-size = 10;
            };
            '';
            default = null;
          };
          layout = mkOption {
            type = types.nullOr (types.attrsOf kdlType);
            example = ''
            layout = {
              gaps = 3;
              active-gradient = {
                option = { 
                  from = "#ffbb66";
                  to = "#ffc880";
                  angle = 45;
                  relative-to = "workspace-view";
                };
              };
            };
            '';
            default = null;
          };
          output = mkOption {
            type = types.nullOr (types.attrsOf kdlType);
            example = ''
            output."eDP-1" = {
              mode = "1920x1080";
              position = [{ x = 0; y = 0; }];
            };
            '';
            default = null;
          };
          input = mkOption {
            type = types.nullOr types.attrs;
            example = ''
            input = {
              keyboard = {
                xkb.layout = "us";
                xkb.variants = "qwerty,";
              };
            };
            '';
            default = null;
          };
          bind = mkOption {
            type = types.nullOr (types.attrsOf (types.submodule {
              options = {
                command = mkOption {
                  type = types.oneOf (with types; [ str int bool (listOf (oneOf [str int bool])) ]);
                  example = ''
                  command = "fullscreen-window";
                  command = spawn = ["amixer" "sset" "Master" "2%-"];
                  '';
                };
                option = mkOption {
                  type = types.nullOr (types.attrsOf primitiveType);
                  example = ''
                  cooldown-ms = 150;
                  '';
                  default = null;
                };
              };
            }));
            example = ''
            "Mod+f" = {
              command = "fullscreen-window";
              options = { cooldown-ms = 150; };
            };
            '';
            default = null;
          };
          window = mkOption {
            type = types.nullOr (types.attrsOf primitiveType);
            example = ''
            window = {
              geometry-corner-radius = 4;
              clip-to-geometry = true;
            };
            '';
            default = null;
          };
        };
      });
      default = null;
    };
    
  };
  config = mkIf cfg.enable {
    xdg.configFile."niri/config.kdl".text = do { inherit (cfg) config extraConfig; };
  };
}
