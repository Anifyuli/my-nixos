{ pkgs, programs, ... }: {

  imports = [
    ./desktop-manager
  ];
  home.username = "fmway";
  home.homeDirectory = "/home/fmway";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # packages
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    swayfx
    swaylock-effects
    dejavu_fonts
  ];

  # Vim configurations.
  programs.vim = import ./vim.nix { inherit pkgs; };

  # i3status-rust
  programs.i3status-rust = import ./i3status-rs.nix { inherit pkgs; };

  # Foot terminal
  programs.foot = import ./foot.nix { inherit pkgs; };

  # Git
  programs.git = {
    enable = true;
    userName = "fmway";
    userEmail = "fm18lv@gmail.com";
  };

    # Lazygit
  programs.lazygit = {
    enable = true;
  };

  # Direnv
  programs.direnv = {
    enable = true;
    # enableFishIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
    stdlib = ''
      session_name() {
        export TMUX_SESSION_NAME="''${*:?session_name needs a name as argument}"
      }
    '';
  };

  # Fish
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      starship init fish | source
      direnv hook fish | source
      printf '\e[5 q'
    '';
  };

  # Carapace
  programs.carapace = {
    enable = true;
    enableFishIntegration = false;
  };

  # Tmux
  programs.tmux = import ./tmux.nix { inherit pkgs; };

  # Home Manager version
  home.stateVersion = "24.05"; 
}
