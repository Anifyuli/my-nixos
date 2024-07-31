{
  # enableFishIntegration = true;
  # I'm frustrated
  # settings = {
  #   keybinds = {
  #     normal = {
  #       # uncomment this and adjust key if using copy_on_select=false
  #         # ''bind "Alt c"'' = { "Copy"; };
  #         "bind 'Alt c'" = {
  #           Copy = [];
  #         };
  #     };
  #     locked = {
  #       "bind 'Ctrl g'" = {
  #         SwitchToMode = "Normal";
  #       };
  #     };
  #     resize = {
  #       "bind 'Ctrl n'" = {
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'h' 'Left'" = { 
  #         Resize = "Increase Left";
  #       };
  #       "bind 'j' 'Down'" = {
  #         Resize = "Increase Down";
  #       };
  #       "bind 'k' 'Up'" = {
  #         Resize = "Increase Up";
  #       };
  #       "bind 'l' 'Right'" = {
  #         Resize = "Increase Right";
  #       };
  #       "bind 'H'" = {
  #         Resize = "Decrease Left";
  #       };
  #       "bind 'J'" = {
  #         Resize = "Decrease Down";
  #       };
  #       "bind 'K'" = {
  #         Resize = "Decrease Up";
  #       };
  #       "bind 'L'" = { 
  #         Resize = "Decrease Right";
  #       };
  #       "bind '=' '+'" = {
  #         Resize = "Increase";
  #       };
  #       "bind '-'" = {
  #         Resize = "Decrease";
  #       };
  #     };
  #     pane = {
  #       "bind 'Ctrl p'" = {
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'h' 'Left'" = {
  #         MoveFocus = "Left";
  #       };
  #       "bind 'l' 'Right'" = {
  #         MoveFocus = "Right";
  #       };
  #       "bind 'j' 'Down'" = {
  #         MoveFocus = "Down";
  #       };
  #       "bind 'k' 'Up'" = {
  #         MoveFocus = "Up";
  #       };
  #       "bind 'p'" = {
  #         SwitchFocus = [];
  #       };
  #       "bind 'n'" = {
  #         NewPane = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'd'" = {
  #         NewPane = "Down";
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'r'" = {
  #         NewPane = "Right";
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'x'" = {
  #         CloseFocus = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'f'" = {
  #         ToggleFocusFullscreen = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'z'" = {
  #         TogglePaneFrames = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'w'" = {
  #         ToggleFloatingPanes = []; 
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'e'" = {
  #         TogglePaneEmbedOrFloating = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'c'" = {
  #         SwitchToMode = "RenamePane";
  #         PaneNameInput = 0;
  #       };
  #     };
  #     move = {
  #       "bind 'Ctrl h'" = {
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'n' 'Tab'" = {
  #         MovePane = [];
  #       };
  #       "bind 'p'" = {
  #         MovePaneBackwards = [];
  #       };
  #       "bind 'h' 'Left'" = {
  #         MovePane = "Left";
  #       };
  #       "bind 'j' 'Down'" = {
  #         MovePane = "Down";
  #       };
  #       "bind 'k' 'Up'" = {
  #         MovePane = "Up";
  #       };
  #       "bind 'l' 'Right'" = {
  #         MovePane = "Right";
  #       };
  #     };
  #     tab = {
  #       "bind 'Ctrl t'" = {
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'r'" = {
  #         SwitchToMode = "RenameTab";
  #         TabNameInput = 0;
  #       };
  #       "bind 'h' 'Left' 'Up' 'k'" = {
  #         GoToPreviousTab = [];
  #       };
  #       "bind 'l' 'Right' 'Down' 'j'" = {
  #         GoToNextTab = []; 
  #       };
  #       "bind 'n'" = {
  #         NewTab = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'x'" = {
  #         CloseTab = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 's'" = {
  #         ToggleActiveSyncTab = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'b'" = {
  #         BreakPane = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind ']'" = {
  #         BreakPaneRight = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind '['" = {
  #         BreakPaneLeft = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind '1'" = {
  #         GoToTab = 1;
  #         SwitchToMode = "Normal";
  #       };
  #       "bind '2'" = {
  #         GoToTab = 2;
  #         SwitchToMode = "Normal";
  #       };
  #       "bind '3'" = {
  #         GoToTab = 3;
  #         SwitchToMode = "Normal";
  #       };
  #       "bind '4'" = {
  #         GoToTab = 4;
  #         SwitchToMode = "Normal";
  #       };
  #       "bind '5'" = {
  #         GoToTab = 5;
  #         SwitchToMode = "Normal";
  #       };
  #       "bind '6'" = {
  #         GoToTab = 6;
  #         SwitchToMode = "Normal";
  #       };
  #       "bind '7'" = {
  #         GoToTab = 7;
  #         SwitchToMode = "Normal";
  #       };
  #       "bind '8'" = {
  #         GoToTab = 8;
  #         SwitchToMode = "Normal";
  #       };
  #       "bind '9'" = {
  #         GoToTab = 9;
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'Tab'" = {
  #         ToggleTab = [];
  #       };
  #     };
  #     scroll = {
  #       "bind 'Ctrl s'" = {
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'e'" = {
  #         EditScrollback = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 's'" = {
  #         SwitchToMode = "EnterSearch";
  #         SearchInput = 0;
  #       };
  #       "bind 'Ctrl c'" = {
  #         ScrollToBottom = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'j' 'Down'" = {
  #         ScrollDown = [];
  #       };
  #       "bind 'k' 'Up'" = {
  #         ScrollUp = [];
  #       };
  #       "bind 'Ctrl f' 'PageDown' 'Right' 'l'" = { 
  #         PageScrollDown = []; 
  #       };
  #       "bind 'Ctrl b' 'PageUp' 'Left' 'h'" = { 
  #         PageScrollUp = [];
  #       };
  #       "bind 'd'" = {
  #         HalfPageScrollDown = [];
  #       };
  #       "bind 'u'" = {
  #         HalfPageScrollUp = [];
  #       };
  #       # uncomment this and adjust key if using copy_on_select=false
  #       # "bind 'Alt c'" = {
  #       #   Copy = [];
  #       # };
  #     };
  #     search = {
  #       "bind 'Ctrl s'" = {
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'Ctrl c'" = {
  #         ScrollToBottom = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'j' 'Down'" = {
  #         ScrollDown = [];
  #       };
  #       "bind 'k' 'Up'" = {
  #         ScrollUp = [];
  #       };
  #       "bind 'Ctrl f' 'PageDown' 'Right' 'l'" = {
  #         PageScrollDown = [];
  #       };
  #       "bind 'Ctrl b' 'PageUp' 'Left' 'h'" = {
  #         PageScrollUp = [];
  #       };
  #       "bind 'd'" = {
  #         HalfPageScrollDown = [];
  #       };
  #       "bind 'u'" = {
  #         HalfPageScrollUp = [];
  #       };
  #       "bind 'n'" = {
  #         Search = "down";
  #       };
  #       "bind 'p'" = {
  #         Search = "up";
  #       };
  #       "bind 'c'" = {
  #         SearchToggleOption = "CaseSensitivity";
  #       };
  #       "bind 'w'" = {
  #         SearchToggleOption = "Wrap";
  #       };
  #       "bind 'o'" = {
  #         SearchToggleOption = "WholeWord";
  #       };
  #     };
  #     entersearch = {
  #       "bind 'Ctrl c' 'Esc'" = {
  #         SwitchToMode = "Scroll";
  #       };
  #         "bind 'Enter'" = {
  #         SwitchToMode = "Search";
  #       };
  #     };
  #     renametab = {
  #       "bind 'Ctrl c'" = {
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'Esc'" = {
  #         UndoRenameTab = [];
  #         SwitchToMode = "Tab";
  #       };
  #     };
  #     renamepane = {
  #       "bind 'Ctrl c'" = {
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'Esc'" = {
  #         UndoRenamePane = [];
  #         SwitchToMode = "Pane";
  #       };
  #     };
  #     session = {
  #       "bind 'Ctrl o'" = {
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'Ctrl s'" = {
  #         SwitchToMode = "Scroll";
  #       };
  #       "bind 'd'" = {
  #         Detach = [];
  #       };
  #       "bind 'w'" = {
  #         "LaunchOrFocusPlugin 'session-manager'" = {
  #           floating = true;
  #           move_to_focused_tab = true;
  #         };
  #         SwitchToMode = "Normal";
  #       };
  #     };
  #     tmux = {
  #       "bind '['" = {
  #         SwitchToMode = "Scroll";
  #       };
  #       "bind 'Ctrl b'" = {
  #         Write = 2;
  #         SwitchToMode = "Normal";
  #       };
  #       "bind '\\\"' '-'" = {
  #         NewPane = "Down";
  #         SwitchToMode = "Normal";
  #       };
  #       "bind '%' '|'" = {
  #         NewPane = "Right"; 
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'z'" = {
  #         ToggleFocusFullscreen = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'c'" = {
  #         NewTab = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind ','" = {
  #         SwitchToMode = "RenameTab";
  #       };
  #       "bind 'e'" = {
  #           "Run 'nvim'" = {
  #             cwd = "/home/fmway/.config/zellij";
  #           };
  #           TogglePaneEmbedOrFloating = [];
  #           SwitchToMode = "Normal";
  #       };
  #       "bind 'g'" = {
  #           "Run 'lazygit'" = [];
  #           TogglePaneEmbedOrFloating = [];
  #           SwitchToMode = "Normal";
  #       };
  #
  #       "bind 'p'" = {
  #         GoToPreviousTab = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'n'" = {
  #         GoToNextTab = []; 
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'Left' 'h'" = {
  #         MoveFocus = "Left";
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'Right' 'l'" = {
  #         MoveFocus = "Right"; 
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'Down' 'j'" = {
  #         MoveFocus = "Down";
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'Up' 'k'" = {
  #         MoveFocus = "Up";
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'o'" = {
  #         FocusNextPane = [];
  #       };
  #       "bind 'Space'" = {
  #         NextSwapLayout = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'x'" = {
  #         CloseFocus = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'r'" = {
  #         SwitchToMode = "Resize";
  #       };
  #       "bind 'P'" = {
  #         SwitchToMode = "Pane";
  #       };
  #       "bind 'L'" = {
  #         SwitchToMode = "Locked";
  #       };
  #       "bind 's'" = {
  #         SwitchToMode = "Session";
  #       };
  #       "bind 't'" = {
  #         SwitchToMode = "Tab";
  #       };
  #       "bind 'm'" = {
  #         SwitchToMode =  "Move";
  #       };
  #       "bind 'f'" = {
  #         ToggleFloatingPanes = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'F'" = {
  #         TogglePaneEmbedOrFloating = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'Alt =' 'Alt +'" = {
  #         Resize = "Increase";
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'Alt -'" = {
  #         Resize = "Decrease"; 
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'Alt ['" = {
  #         PreviousSwapLayout = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'Alt ]'" = {
  #         NextSwapLayout = [];
  #         SwitchToMode = "Normal";
  #       };
  #       "bind 'd'" = {
  #         Detach = [];
  #       };
  #     };
  #     "shared_except 'locked'" = {
  #       "bind 'Alt n'" = {
  #         NewPane = []; 
  #       };
  #       "unbind 'Alt i'" = [];
  #       "unbind 'Alt o'" = [];
  #       "unbind 'Alt h'" = [];
  #       "unbind 'Alt j'" = [];
  #       "unbind 'Alt k'" = [];
  #       "unbind 'Alt l'" = [];
  #       "unbind 'Alt Left'" = [];
  #       "unbind 'Alt Right'" = [];
  #       "unbind 'Alt Up'" = [];
  #       "unbind 'Alt Down'" = [];
  #       "unbind 'Alt ='" = [];
  #       "unbind 'Alt +'" = [];
  #       "unbind 'Alt -'" = [];
  #       "unbind 'Ctrl g'" = [];
  #       "unbind 'Alt ['" = [];
  #       "unbind 'Alt ]'" = [];
  #     };
  #     "shared_except 'normal' 'locked'" = {
  #       "bind 'Enter' 'Esc'" = {
  #         SwitchToMode = "Normal";
  #       };
  #     };
  #     "shared_except 'pane' 'locked'" = {
  #       "unbind 'Ctrl p'" = [];
  #     };
  #     "shared_except 'resize' 'locked'" = {
  #       "unbind 'Ctrl n'" = [];
  #     };
  #     "shared_except 'scroll' 'locked'" = {
  #       "unbind 'Ctrl s'" = [];
  #     };
  #     "shared_except 'session' 'locked'" = {
  #       "unbind 'Ctrl o'" = [];
  #     };
  #     "shared_except 'tab' 'locked'" = {
  #       "unbind 'Ctrl t'" = []; 
  #     };
  #     "shared_except 'move' 'locked'" = {
  #       "unbind 'Ctrl h'" = [];
  #     };
  #     "shared_except 'tmux' 'locked'" = {
  #       "unbind 'Ctrl b'" = [];
  #     };
  #   };
  #   plugins = {
  #     "tab-bar location='zellij:tab-bar'" = [];
  #     "status-bar location='zellij:status-bar'" = [];
  #     "strider location='zellij:strider'" = [];
  #     "compact-bar location='zellij:compact-bar'" = [];
  #     "session-manager location='zellij:session-manager'" = [];
  #     "welcome-screen location='zellij:session-manager'" = {
  #       welcome_screen = false;
  #     };
  #     "filepicker location='zellij:strider'" = {
  #       cwd = "/";
  #     };
  #   };
  #   auto_layout = true;
  #   session_serialization = false;
  #   theme = "catppuccin-macchiato";
  #   default_layout = "kontol";
  #   mouse_mode = true;
  #   copy_command = "wl-copy";
  #   copy_on_select = true;
  # };
}
