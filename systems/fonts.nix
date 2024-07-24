{ pkgs, ... }:
{
  # add fonts
  fontDir.enable = true;
  packages = with pkgs; [
    # amiri
    corefonts
    # clearlyU
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    roboto
    nerdfonts
    dejavu_fonts
    roboto-serif
  ];
}
