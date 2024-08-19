{ pkgs, extra, ... }:
{
  baseIndex = 1;
  clock24 = true;
  extraConfig = extra.tmux;
  customPaneNavigationAndResize = true; # Override the hjkl and HJKL bindings for pane navigation and resizing in VI mode.
  plugins = with pkgs.tmuxPlugins; [
    {
      plugin = catppuccin;
      extraConfig = extra.catppuccin;
    }
    battery
    logging
    jump
    yank
    copycat
    prefix-highlight
    pain-control
    fzf-tmux-url
  ];
}
