{ pkgs, ... }:
{
  enable = true;
  interactiveShellInit = ''
    set fish_greeting # Disable greeting
    starship init fish | source
    direnv hook fish | source
    printf '\e[5 q'
  '';
}
