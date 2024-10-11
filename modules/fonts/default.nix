{ pkgs, ... }:

{
  # Add fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      amiri
      corefonts
      dm-sans
      fira
      fira-code-nerdfont
      fira-code-symbols
      lato
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      open-sans
      roboto
      roboto-serif
      roboto-slab
      vistafonts
      work-sans
    ];
  };
}
