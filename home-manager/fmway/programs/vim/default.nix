# a modal text editor
{ lib, pkgs, ... }: {
  packageConfigurable = pkgs.vim;
  defaultEditor = true;
  settings = {
    expandtab = true;
    mouse = "a";
    number = true;
    shiftwidth = 2;
    tabstop = 2;
  };
  extraConfig = lib.fileContents ./vimrc;
  plugins = with pkgs.vimPlugins; [
    gruvbox-community
    vim-airline
    vim-airline-themes
    vim-lastplace
    vim-lsp
    vim-lsp-settings
    vim-nix
  ];
}
