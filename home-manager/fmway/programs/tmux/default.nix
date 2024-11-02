# terminal multiplexer
{ pkgs, extra, ... }:
{
  baseIndex = 1;
  clock24 = true;
  extraConfig = extra.tmux;
  escapeTime = 0;
  mouse = true; # mouse support
  newSession = true; # create new session when attack and none
  terminal = "screen-256color";
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
