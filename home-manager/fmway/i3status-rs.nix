{ pkgs, ... }:let
  terminal = "${pkgs.foot}/bin/footclient";
  menu = "${pkgs.dmenu}/bin/dmenu";
in 
{
  enable = true;
  bars = {
    top = {
      blocks = [
        {
          block = "focused_window";
          format = " {$title.str(max_width:40) | awkwokoakwo} \\|";
        }
        # {
          # block = "kdeconnect";
          # format = " $icon {$bat_icon   $bat_charge |}{$network_icon  $network_type|}{ $notif_icon $notif_count|}";
          # bat_good = 101;
          # click = [
            # {
              # button = "left";
              # cmd = "killall kdeconnect-app || kdeconnect-app";
            # }
          # ];
        # }
        {
          block = "sound";
          click = [
          {
            button = "left";
            cmd = "amixer sset Master toggle";
          }
          {
            button = "right";
            cmd = "killall pavucontrol || pavucontrol";
          }
          ];
        }
        {
          block = "bluetooth";
          mac = "A3:AD:A5:B0:5F:62";
          format = " $icon  $name{ $percentage|} ";
          disconnected_format = "";
          battery_state = {
            "0..20" = "critical";
            "21..70" = "warning";
            "71..100" = "good";
          };
        }
        {
          block = "net";
          format = " $icon {$ssid $speed_up ^icon_net_up  $speed_down ^icon_net_down  $signal_strength|Wired connection}";
          # click = [
          # {
            # button = "left";
            # cmd = "killall iwgtk || iwgtk";
          # }
          # ];
        }
        {
          block = "disk_space";
          path = "/";
          info_type = "used";
          interval = 60;
          warning = 80;
          alert = 90;
          format = " $icon $used.eng(w:2) / $total.eng(w:2) ";
          click = [
          {
            button = "left";
            cmd = "footclient -a floating-window ncdu .";
          }
          ];
        }
        # { block = "cpu"; }
        {
          block = "memory";
          format = " $icon  $mem_used.eng(w:2) ";
          format_alt = " $icon_swap  $swap_used.eng(w:2) ";
          click = [
          {
            button = "right";
            cmd = "${terminal} -a fullscreen-window -T floating-window btop";
          }
          ];
        }
        {
          block = "battery";
          format = " $icon   $percentage {$time |}";
          device = "DisplayDevice";
          driver = "upower";
        }
        {
          block = "time";
          interval = 5;
          format = " $icon $timestamp.datetime(f:'%a %R')";
        }
        {
          block = "custom";
          command = ''echo ⏻'';
          interval = "once";
          click = [
          {
            button = "left";
            cmd = "systemctl `echo -e 'suspend\npoweroff\nreboot' | ${menu}`";
          }
          ];
        }
      ];
      theme = "bad-wolf";
      icons = "awesome6";
    };
  };
}
