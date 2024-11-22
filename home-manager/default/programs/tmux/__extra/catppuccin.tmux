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
