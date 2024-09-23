## Home Manager as NixOS module
{ config, pkgs, modulesPath, ... }:

{
  home-manager.users.anifyuli = { pkgs, ... }: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "anifyuli";
  home.homeDirectory = "/home/anifyuli";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    exercism
    php82Packages.composer
    pnpm
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

  home.sessionPath = [ 
    "$HOME/.android/sdk/cmdline-tools/latest/bin/"
    "$HOME/.android/sdk/emulator"
    "$HOME/.android/sdk/platform-tools"
  ];

  # Environment variables for $HOME
  home.sessionVariables = {
    ANDROID_SDK_ROOT = "$HOME/.android/sdk";
  };

  # dircolors configurations
  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
  };

  # Golang configurations.
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
        colorscheme gruvbox
        set softtabstop=2
        set smartindent
    '';
    plugins = with pkgs.vimPlugins; [
      gruvbox-community
      vim-lastplace
      vim-nix
    ];
  };

  # Home Manager version
  home.stateVersion = "24.11";  
};
}
