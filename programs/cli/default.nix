{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # vim
    neovim
    # speechd
    # neovim-maximal
    wget
    doas
    starship
    zip
    unzip
    ffmpeg-full
    fwupd
    tree
    btop
    waypipe
  ];
}
