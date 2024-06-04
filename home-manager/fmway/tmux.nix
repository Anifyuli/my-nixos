{ pkgs, ... }:
{
  enable = true;
  clock24 = true;
  extraConfig = with pkgs.tmuxPlugins; ''
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

    # Set the base index for windows to 1 instead of 0.
    set -g base-index 1

    # Set the base index for panes to 1 instead of 0.
    setw -g pane-base-index 1

    # Show pane details.
    set -g pane-border-status top
    set -g pane-border-format '<(#P) #{pane_title}>'
    set -g @catppuccin_pane_border_format '<(#P) #{pane_title}>'
    # set -g pane-border-format "mancing"

    #catpuccin
    set -g @catppuccin_flavour 'frappe' #latte frappe, macchiato, mocha
    set -g @catppuccin_window_left_separator "█"
    set -g @catppuccin_window_right_separator "█ "
    set -g @catppuccin_window_number_position "right"
    set -g @catppuccin_window_middle_separator "  █"
    set -g @catppuccin_window_default_fill "number"
    set -g @catppuccin_window_default_text "#W"

    set -g @catppuccin_window_current_fill "number"
    set -g @catppuccin_window_current_text "#W"
    set -g @catppuccin_status_modules_right "directory user host session date_time"
    set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M"
    #set -g @catppuccin_prepend 'anjimlah'
    set -g @catppuccin_directory_text "#{pane_current_path}"

    #set -g status-right '#{prefix_highlight} | #{online_status} | %a %Y-%m-%d %H:%M'
    #set -g status-right '#{pomodoro_status}'
    #set -g status-right "#{?window_bigger,[#{window_offset_x}#,#{window_offset_y}] ,}\"#{=21:pane_title}\" %H:%M:%S %d-%b-%y"
    # set -g status-right "#{?window_bigger,[#{window_offset_x}#,#{window_offset_y}] ,}\"#{=21:pane_title}\"#{prefix_highlight} %H:%M %d-%b-%y"

    run-shell ${sensible}/share/tmux-plugins/sensible/sensible.tmux
    run-shell ${battery}/share/tmux-plugins/battery/battery.tmux
    run-shell ${logging}/share/tmux-plugins/logging/logging.tmux
    run-shell ${jump}/share/tmux-plugins/jump/tmux-jump.tmux
    run-shell ${yank}/share/tmux-plugins/yank/yank.tmux
    run-shell ${copycat}/share/tmux-plugins/copycat/copycat.tmux
    run-shell ${online-status}/share/tmux-plugins/online-status/online_status.tmux
    run-shell ${prefix-highlight}/share/tmux-plugins/prefix-highlight/prefix_highlight.tmux
    run-shell ${pain-control}/share/tmux-plugins/pain-control/pain_control.tmux
    run-shell ${catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux
    run-shell ${fzf-tmux-url}/share/tmux-plugins/fzf-tmux-url/fzf-url.tmux
  '';
}
