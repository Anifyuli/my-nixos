{
  enable = true;
  settings = {
    main = {
      font = "DejaVu Sans Mono:style=Bold:size=14";
      pad = "2x2";
    };
    cursor = {
      blink = "yes";
      style = "beam";
      beam-thickness = 1.5;
    };
    colors = {
      alpha = 0.9;
      background = "2C2B40";
      foreground = "B3B3B3";

      ## Normal/regular colors (color palette 0-7)
      regular0 = "2C2B40";  # black
      regular1 = "F05654";  # red
      regular2 = "4CDA87";  # green
      regular3 = "c5e478";  # yellow
      regular4 = "82aaff";  # blue
      regular5 = "c792ea";  # magenta
      regular6 = "21c7a8";  # cyan
      regular7 = "F2F2F2";  # white

      ## Bright colors (color palette 8-15)
      bright0 = "575656";   # bright black
      bright1 = "EF6E6C";   # bright red
      bright2 = "4CDA87";   # bright green
      bright3 = "ffeb95";   # bright yellow
      bright4 = "82aaff";   # bright blue
      bright5 = "c792ea";   # bright magenta
      bright6 = "7fdbca";   # bright cyan
      bright7 = "ffffff";   # bright white
    };
  };
}
