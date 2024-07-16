{ pkgs, ... }:
{
  enable = true;
  nanorc = ''
    set nowrap
    set tabstospaces
    set tabsize 2
    set linenumbers
    set autoindent
    set mouse
  '';
}
