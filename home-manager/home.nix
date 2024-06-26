## Home Manager as NixOS module
{ config, pkgs, ... }:

{
  home-manager.users.anifyuli = { pkgs, ... }: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "anifyuli";
  home.homeDirectory = "/home/anifyuli";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    alacritty-theme
    exercism
    gnomeExtensions.cloudflare-warp-indicator
    gnomeExtensions.x11-gestures
    mongodb-compass
    pnpm
    postman
  ];
  
  # Alacritty
  programs.alacritty= { 
    enable = true;
    settings = {};
  };

  # Bash configurations.
  programs.bash = {
    enable = true;
    enableVteIntegration = true;
    historyControl = [
      "ignoreboth"
      "erasedups"
    ];
    historyIgnore = [
      "?"
      "??"
    ];
    historyFile = "$HOME/.bash_history";
    historyFileSize = 1000000;
    historySize = 1000;
    shellOptions = [
      "autocd"
      "cdspell"
      "checkjobs"
      "direxpand"
      "dirspell" 
      "extglob"
      "globstar" 
      "histappend" 
      "histverify"
      "nocaseglob" 
      "no_empty_cmd_completion"
    ];
    bashrcExtra = "source ~/.bash/themes/aphrodite/aphrodite.theme.sh # Use Aphrodite prompt theme";
  };

  # dircolors configurations
  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
  };
  
  # Fastfetch configurations
  programs.fastfetch = {
    enable = true;
    settings = {
      schema = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      display = {
        separator = " ";
      };
      modules = [
      {
        type = "host";
        key = "╭─󰌢";
        keyColor = "green";
      }
      {
        type = "cpu";
        key = "├─󰻠";
        keyColor = "green";
      }
      {
        type = "gpu";
        key = "├─󰍛";
        keyColor = "green";
      }
      {
        type = "disk";
        key = "├─";
        keyColor = "green";
      }
      {
        type = "memory";
        key = "├─󰑭";
        keyColor = "green";
      }
      {
        type = "swap";
        key = "├─󰓡";
        keyColor = "green";
      }
      {
        type = "display";
        key = "╰─󰍹";
        keyColor = "green";
      }

      "break"

      {
        type = "shell";
        key = "╭─";
        keyColor = "yellow";
      }
      {
        type = "terminal";
        key = "├─";
        keyColor = "yellow";
      }
      {
        type = "terminalfont";
        key = "├─";
        keyColor = "yellow";
      }
      {
        type = "de";
        key = "├─";
        keyColor = "yellow";
      }
      {
        type = "wm";
        key = "├─";
        keyColor = "yellow";
      }
      {
        type = "theme";
        key = "├─󰉼";
        keyColor = "yellow";
      }
      {
        type = "icons";
        key = "╰─󰀻";
        keyColor = "yellow";
      }

      "break"

      {
        type = "title";
        key = "╭─";
        format = "{1}@{2}";
        keyColor = "blue";
      }
      {
        type = "os";
        key = "├─"; # Just get your distro's logo off nerdfonts.com
          keyColor = "blue";
      }
      {
        type = "kernel";
        key = "├─";
        format = "{1} {2}";
        keyColor = "blue";
      }
      {
        type = "packages";
        key = "├─󰏖";
        keyColor = "blue";
      }
      {
        type = "uptime";
        key = "╰─󰅐";
        keyColor = "blue";
      }
      ];
    };
  };

  # Golang configurations.
  programs.go = {
    enable = true;
    goBin = ".go/bin";
    goPath = ".go";
  };
  
  # Vim configurations.
  programs.vim = {
    enable = true;
    packageConfigurable = pkgs.vim;
    defaultEditor = true;
    settings = {
      expandtab = true;
      mouse = "a";
      number = true;
      shiftwidth = 2;
      tabstop = 2;
    };
    extraConfig = ''
      set softtabstop=2
      set smartindent
    '';
  };

  # Home Manager version
  home.stateVersion = "24.11";  
  };

}
