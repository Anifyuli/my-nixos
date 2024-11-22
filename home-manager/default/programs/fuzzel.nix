# dmenu alternative for wayland
{
  settings = {
    main = {
      font = "JetBrainsMono Nerd Font Propo:size=11";
      dpi-aware = "no";
      fields = "name,generic,comment,categories,filename,keywords";
      terminal = "$TERMINAL -e";
      prompt = "🔍 ";
      # icon-theme = "Papirus-Dark";
      icons-enabled = "yes";
      show-actions = "yes";
      lines = 10;
      width = 50;
      horizontal-pad = 20;
      vertical-pad = 20;
      inner-pad = 5;
      line-height = 20;
      letter-spacing = 0;
      image-size-ratio = 0.5;
      layer = "top";
      exit-on-keyboard-focus-loss = "yes";
    };
    colors = {
      background = "1a1b26ff";
      text = "7c72a0ff";
      match = "ff6000ff";
      selection = "1793d1ff";
      selection-text = "120024ff";
      border = "1793d1ff";
    };
    border = {
      width = 2;
      radius = 10;
    };
  };
}
