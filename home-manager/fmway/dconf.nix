{ pkgs, lib, ... }:
let
  # parse normal attrs to dconf familiar
  dconfFamiliar = obj: let
    func = prefix: obj:
      builtins.foldl' (res: x: let
        value = obj.${x};
      in lib.recursiveUpdate res (if builtins.isAttrs value then let
        key = if prefix == "" then x else builtins.concatStringsSep "/" [ prefix x ];
      in 
        func key value
      else {
        "${prefix}"."${x}" = value;
      })) {} (builtins.attrNames obj);
  in func "" obj;
in {
  enable = true;
  settings = dconfFamiliar {
    org.gnome.shell = {
      disable-user-extensions = false;
      enabled-extensions = map (x:
        if builtins.isString x then
          x
        else x.extensionUuid)
      (with pkgs.gnomeExtensions; [
        blur-my-shell
        gsconnect
        paperwm
        appindicator
        clipboard-indicator
        thinkpad-battery-threshold
        blur-my-shell
        # net-speed
        totp
        cloudflare-warp-toggle
        system-monitor
        weather-oclock
        bing-wallpaper-changer
        places-status-indicator
        applications-menu
        "emoji-copy@felipeftn"
        "day-progress@arcaege.github.io"
        "lilypad@shendrew.github.io"
      ]);

      # extensions settings
      extensions = {
        # paperwm
        paperwm = {
          default-focus-mode = 0;
          open-window-position = 0; # right
          keybindings.toggle-scratch = [ "<Shift><Super>space" ];
        };

        system-monitor = {
          show-cpu = true;
          show-download = true;
          show-memory = true;
          show-upload = true;
          show-swap = false;
        };
      };
    };

    org.gnome.desktop = {
      interface.color-scheme = "prefer-dark"; # dark mode

      # Change background
      # background = {
      #   picture-uri = "file:///<path>";
      #   picture-uri-dark = "file:///<path>";
      # };
    };
  } // 
  # custom shortuct
  (let
    keybindings = l: # list of { name :: string, binding :: string, command :: string }
      builtins.listToAttrs (lib.lists.imap0 (i: v: let
        key = "custom${toString i}";
      in {
        name = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/${key}";
        value = with lib.gvariant; {
          name = mkString (if v ? name then v.name else key);
          binding = mkString v.binding;
          command = mkString "${v.command}";
        };
      }) l);
  in keybindings [
    {
      name = "increment cursor size";
      binding = "<Alt><Super>equal";
      command = pkgs.writeScript "increment-cursor" ''
        #!${lib.getExe pkgs.bash}
        CURRENT=$(gsettings get org.gnome.desktop.interface cursor-size)
        gsettings set org.gnome.desktop.interface cursor-size $(( CURRENT + 1 ))
      '';
    }
    {
      name = "decrement cursor size";
      binding = "<Alt><Super>minus";
      command = pkgs.writeScript "decrement-cursor" ''
        #!${lib.getExe pkgs.bash}
        CURRENT=$(gsettings get org.gnome.desktop.interface cursor-size)
        [ ! -z $CURRENT ] &&
          [ $CURRENT -ge 1 ] &&
          gsettings set org.gnome.desktop.interface cursor-size $(( CURRENT - 1 ))
      '';
    }
  ]);
}
