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
      enabled-extensions = map (x: x.extensionUuid) (with pkgs.gnomeExtensions; [
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
  };
}
