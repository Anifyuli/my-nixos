## Home Manager as NixOS module
{
  home-manager.users.anifyuli = { pkgs, ... }: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "anifyuli";
  home.homeDirectory = "/home/anifyuli";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    cachix
    devenv
    exercism
    gradle
    nixd
    nixfmt-rfc-style
    nixpkgs-fmt
    php82Packages.composer
    pnpm
    universal-android-debloater
  ];

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
    bashrcExtra = "";
  };

  # Shell aliases
  home.shellAliases = {
    "warpstat" = "curl https://www.cloudflare.com/cdn-cgi/trace/";
  };

  # direnv setup
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  # Session path
  home.sessionPath = [ 
    "$HOME/.android/sdk/cmdline-tools/latest/bin/"
    "$HOME/.android/sdk/emulator"
    "$HOME/.android/sdk/platform-tools"
  ];

  # Environment variables for $HOME
  home.sessionVariables = {
    ANDROID_HOME = "$HOME/.android/sdk";
    ANDROID_AVD_HOME = "$HOME/.android/avd";
    ANDROID_SDK_ROOT = "$ANDROID_HOME";
  };

  # dircolors configurations
  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
  };

  # Golang configurations
  programs.go = {
    enable = true;
    goBin = ".go/bin";
    goPath = ".go";
  };

  # Fastfetch configurations
  programs.fastfetch = import ./config/fastfetch.nix;

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
      " Enable softtabstop & smartindent
      set softtabstop=2
      set smartindent

      " Enable colorscheme
      colorscheme gruvbox

      " Airline & theming it
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#left_sep = ' '
      let g:airline#extensions#tabline#left_alt_sep = '|'
      let g:airline#extensions#tabline#formatter = 'default'
      let g:airline_theme='gruvbox'
    '';
    plugins = with pkgs.vimPlugins; [
      gruvbox-community
      vim-airline
      vim-airline-themes
      vim-lastplace
      vim-lsp
      vim-lsp-settings
      vim-nix
    ];
  };

  # Home Manager version
  home.stateVersion = "24.11";  
  };
}
