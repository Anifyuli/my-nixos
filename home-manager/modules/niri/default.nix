{ lib, config, excludeItems, pkgs, ... }: let
  inherit (lib) mapAttrs' getExe' mkIf mkEnableOption flatten mkOption reverseList strings mkAfter types lists;
  inherit (pkgs.functions) stringMultiply;
  inherit (builtins) foldl' length isString hasAttr concatStringsSep isAttrs isBool isList listToAttrs pathExists elem head attrNames readDir;
  primitip = with types; [ int str bool ];
  primitiveType = types.oneOf primitip;
  kdlType = types.oneOf [
    primitiveType
    (types.attrsOf kdlType)
    (types.listOf kdlType)
  ];

  parse-startup = list: let
    cmd = "spawn-at-startup";
  in foldl' (acc: curr: acc + "${cmd} ${strings.toJSON curr.command}\n") "" list;

  toKV = obj: let
    names = attrNames obj;
  in concatStringsSep " " (map (key: "${key}=${strings.toJSON obj.${key}}") names);

  simple-parse = name: obj: { avoid-boolean ? false, extra ? "", spaces ? 0, excludes ? [], recursive ? false, ... }: let
    object = excludeItems excludes obj;
    names = attrNames object;
    space = stringMultiply " " spaces;
    first = "${space}${name}" + (if object == {} then "" else " {\n");
    last = (if object == {} then "" else "${space}}") + "\n";
    result = foldl' (acc: name: let
      value = object.${name};
    in acc +
      (if isBool value && avoid-boolean then 
        if value then "${space}  ${name}\n" else ""
      else if isAttrs value && recursive then
        simple-parse name value { inherit recursive avoid-boolean; spaces = spaces + 2; }
      else if isList value then let
        len = length value;
        condition = len > 1 && isAttrs (lists.last value);
        arr = if condition then lists.take (len - 1) value else value;
        result = foldl' (acc: curr: "${acc} " + (
          if isAttrs curr then
            toKV curr
          else
            strings.toJSON curr)
        ) name arr;
      in 
        (if condition then
          simple-parse result (lists.last value) { inherit recursive avoid-boolean; spaces = spaces + 2; }
        else "${space}  ${result}") + "\n"
      else
        "${space}  ${name} ${strings.toJSON value}\n")) "" names;
  in first + result + (if extra != "" then "\n${extra}\n" else extra) + last;
  # parse-bind = obj: let
  #   keys = attrNames obj;
  #   result = map (key: let
  #     value = obj.${key};
  #   in concatStringsSep " " (flatten [ "  " key (if value ? option && ! isNull value.option then
  #     (toKV value.option)
  #   else []) "{" (if isList value.command then 
  #     map (x: if x == (head value.command) then
  #       x
  #     else strings.toJSON x) value.command
  #   else value.command) "; }"])) keys;
  # in "binds {\n" + (concatStringsSep "\n" result) + "\n}\n"; 
  parse-alt = name: obj: excludes: let
    names = attrNames obj;
    result = map (key:
      simple-parse ''${name} "${key}"'' obj.${key}  { 
        avoid-boolean = true;
        recursive = true;
        inherit excludes;
      }
    ) names; 

  in (concatStringsSep "\n" result) + "\n";

  cfg = config.wayland.windowManager.niri;

  do = { config, extraConfig, extra, ... }:
    (if isNull config.startup then
      "" else parse-startup config.startup) +
    (if isNull config.environment then
      "" else simple-parse "environment" config.environment {}) +
    (if isNull config.input then
      "" else simple-parse "input" config.input { avoid-boolean = true; recursive = true; }) +
    (if isNull config.output then
      "" else parse-alt "output" config.output []) +
    (if isNull config.workspace then
      "" else parse-alt "workspace" config.workspace [ "shortcut" ]) +
    (if isNull config.output then
      "" else simple-parse "hotkey-overlay" config.hotkey { avoid-boolean = true; }) +
    (if isNull config.window then 
      "" else simple-parse "window-rule" config.window {}) +
    (if isNull config.cursor then
      "" else simple-parse "cursor" config.cursor {}) +
    (if isNull config.bind then
      "" else simple-parse "binds" config.bind { avoid-boolean = true; recursive = true; }) +
    (if isNull config.layout then
      "" else simple-parse "layout" config.layout { avoid-boolean = true; extra = extra.layout; recursive = true; }) +
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
    workspace = mkOption {
      type = types.attrs;
      default = {};
    };
    extraConfig = mkOption {
      type = types.nullOr types.str;
      default = null;
    };
    lock = mkOption {
      type = types.submodule {
        options = {
          enable = mkEnableOption "enable auto lock";
          timeout = mkOption {
            type = types.int;
            description = "timeout in milisecond";
            example = ''lock.timeout = 1000'';
            default = 1000;
          };
        };
      };
    };
    background = mkOption {
      type = types.submodule {
        options = {
          enable = mkEnableOption "enable background inside systemd services";
          path = mkOption {
            type = types.oneOf [ types.path types.str ];
          };
          mode = mkOption {
            type = types.enum [ "stretch" "fit" "fill" "center" "tile" "solid_color" ];
            default = "fill";
          };
        };
      };
      default = {};
    };
    extra = mkOption {
      type = types.submodule {
        options = {
          layout = mkOption {
            type = types.str;
            default = "";
          };
        };
      };
    };
    config = mkOption {
      type = types.nullOr (types.submodule {
        options = {
          prefer-no-csd = mkEnableOption "prefer-no-csd";
          screenshot-path = mkOption { type = types.nullOr types.str; default = null; };
          workspace = mkOption {
            type = types.nullOr (types.attrsOf (types.oneOf [
            (types.submodule ({ name, ... }: {
              options = {
                shortcut = mkOption {
                  type = types.str;
                  default = name;
                };
              };
            }))
            kdlType
            ]));
            default = null;
          };
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
            type = types.nullOr (types.attrsOf kdlType);
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
    wayland.windowManager.niri.workspace = mkIf (!isNull cfg.config.workspace) (let
      result = mapAttrs' (name: value: {
        name = value.shortcut;
        value = name;
      }) cfg.config.workspace;
    in mkAfter result);
    xdg.configFile."niri/config.kdl".text = do { inherit (cfg) config extraConfig extra; };
    home.packages = mkAfter [ cfg.package ];
    systemd.user = let
      lock = "${pkgs.swaylock}/bin/swaylock";
      idle = "${pkgs.swayidle}/bin/swayidle";
      inherit (cfg.lock) timeout;
      systemctl = config.systemd.user.systemctlPath;
    in  {
      services.niri-lock = mkIf cfg.lock.enable {
        Unit = {
          PartOf = "graphical-session.target";
          After = "graphical-session.target";
          Requisite = "graphical-session.target";
        };
        Service = {
          ExecStart = "${idle} -w timeout ${toString (timeout + 1)} 'niri msg action power-off-monitors' timeout ${toString timeout} '${lock} -f' before-sleep '${lock} -f'";
          Restart = "on-failure";
        };
        Install = {
          WantedBy = ["niri.service"];
        };
      };

      services.niri-background = mkIf (cfg.background.enable) {
        Unit = {
          PartOf = "graphical-session.target";
          After = "graphical-session.target";
          Requisite = "graphical-session.target";
        };
        Service = {
          ExecStart = ''${pkgs.swaybg}/bin/swaybg -m ${cfg.background.mode} -i "${toString cfg.background.path}"'';
          Restart = "on-failure";
        };
        Install = {
          WantedBy = ["niri.service"];
        };
      };

      # for handle if background changed
      services.niri-background-watcher = mkIf cfg.background.enable {
        Install = {
          WantedBy = [ "niri.service" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${systemctl} --user restart niri-background.service";
        };
      };
      paths.niri-background-watcher = mkIf cfg.background.enable {
        Path = {
          # PathModified = "${cfg.background.path}";
          PathChanged = "${cfg.background.path}";
        };
        Install = {
          WantedBy = [ "niri.service" ];
        };
      };
    };
  };
}
