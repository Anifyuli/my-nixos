{ pkgs, ... }:
{
  enable = true;
  clock24 = true;
  extraConfig = ''
    set -g mouse on
    set -g allow-passthrough on
    tmux_commands_with_legacy_scroll="nano less more man git"
    
    bind-key -T root WheelUpPane \
      if-shell -Ft= '#{?mouse_any_flag,1,#{pane_in_mode}}' \
        'send -Mt=' \
        'if-shell -t= "#{?alternate_on,true,false} || echo \"#{tmux_commands_with_legacy_scroll}\" | grep -q \"#{pane_current_command}\"" \
          "send -t= Up" "copy-mode -et="'

    bind-key -T root WheelDownPane \
      if-shell -Ft = '#{?pane_in_mode,1,#{mouse_any_flag}}' \
        'send -Mt=' \
        'if-shell -t= "#{?alternate_on,true,false} || echo \"#{tmux_commands_with_legacy_scroll}\" | grep -q \"#{pane_current_command}\"" \
        "send -t= Down" "send -Mt="'
    set -g base-index 1

    # Set the base index for windows to 1 instead of 0.
    set -g base-index 1

    # Set the base index for panes to 1 instead of 0.
    setw -g pane-base-index 1

    # Show pane details.
    set -g pane-border-status top
    set -g pane-border-format '<(#P) #{pane_title}>'
    set -g @online_icon "online!"
    set -g @offline_icon "offline!"

    #catpuccin
    set -g @catppuccin_flavour 'frappe' #latte frappe, macchiato, mocha
    #set -g @catppuccin_left_separator "█"
    #set -g @catppuccin_right_separator "█"
    set -g @catppuccin_user "on"
    set -g @catppuccin_host "off"
    set -g @catppuccin_date_time "%Y-%m-%d %H:%M"
    #set -g @catppuccin_prepend 'anjimlah'

    #set -g status-right '#{prefix_highlight} | #{online_status} | %a %Y-%m-%d %H:%M'
    #set -g status-right '#{pomodoro_status}'
    #set -g status-right "#{?window_bigger,[#{window_offset_x}#,#{window_offset_y}] ,}\"#{=21:pane_title}\" %H:%M:%S %d-%b-%y"
    #set -g status-right "#{?window_bigger,[#{window_offset_x}#,#{window_offset_y}] ,}\"#{=21:pane_title}\"#{prefix_highlight} %H:%M %d-%b-%y"

    run-shell ${pkgs.tmuxPlugins.sensible}/share/tmux-plugins/sensible/sensible.tmux
    run-shell ${pkgs.tmuxPlugins.battery}/share/tmux-plugins/battery/battery.tmux
    run-shell ${pkgs.tmuxPlugins.logging}/share/tmux-plugins/logging/logging.tmux
    run-shell ${pkgs.tmuxPlugins.jump}/share/tmux-plugins/jump/tmux-jump.tmux
    run-shell ${pkgs.tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux
    run-shell ${pkgs.tmuxPlugins.copycat}/share/tmux-plugins/copycat/copycat.tmux
    run-shell ${pkgs.tmuxPlugins.online-status}/share/tmux-plugins/online-status/online_status.tmux
    run-shell ${pkgs.tmuxPlugins.prefix-highlight}/share/tmux-plugins/prefix-highlight/prefix_highlight.tmux
    run-shell ${pkgs.tmuxPlugins.pain-control}/share/tmux-plugins/pain-control/pain_control.tmux
    run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux
  '';
}
