{
  # colors = {
  #   "bg" = "#1e1e1e";
  #   "bg+" = "#1e1e1e";
  #   "fg" = "#d4d4d4";
  #   "fg+" = "#d4d4d4";
  # };

  catppuccin.enable = true;
  catppuccin.flavor = "macchiato";

  tmux.enableShellIntegration = true; # enable tmux integration

  fileWidgetCommand = "fd --type f"; # CTRL+T

  changeDirWidgetCommand = "fd --type d"; # ALT+C

  historyWidgetOptions = [
    "--sort"
    "--exact"
  ]; # CTRL+R
}
