{ pkgs, matchers, replaceStrings', ... }: let
  var = with pkgs.tmuxPlugins; {
    SENSIBLE = "${sensible}/share/tmux-plugins/sensible/sensible.tmux";
    BATTERY = "${battery}/share/tmux-plugins/battery/battery.tmux";
    LOGGING = "${logging}/share/tmux-plugins/logging/logging.tmux";
    JUMP = "${jump}/share/tmux-plugins/jump/tmux-jump.tmux";
    YANK = "${yank}/share/tmux-plugins/yank/yank.tmux";
    COPYCAT = "${copycat}/share/tmux-plugins/copycat/copycat.tmux";
    ONLINE-STATUS = "${online-status}/share/tmux-plugins/online-status/online_status.tmux";
    PREFIX-HIGHLIGHT = "${prefix-highlight}/share/tmux-plugins/prefix-highlight/prefix_highlight.tmux";
    PAIN-CONTROL = "${pain-control}/share/tmux-plugins/pain-control/pain_control.tmux";
    CATPPUCCIN = "${catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux";
    FZF-TMUX-URL = "${fzf-tmux-url}/share/tmux-plugins/fzf-tmux-url/fzf-url.tmux";
  }; 
in 
[
  {
    match = matchers.prefix "extraConfig";
    alias = value: replaceStrings' var {} value;
  }
]
