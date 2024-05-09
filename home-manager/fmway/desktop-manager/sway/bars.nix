{ pkgs, ... }:
[
  {
    position = "top";
    fonts = {
      names = [ "Noto Sans" ];
      size = 10.0;
    };
    statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
  }
]
