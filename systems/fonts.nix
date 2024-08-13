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
    liberation_ttf
    (nerdfonts.override {
      fonts = [
        # "Agave"
        # "AnonymousPro"
        # "CascadiaCode"
        # "CascadiaMono"
        # "DroidSansMono"
        "DejaVuSansMono"
        "FiraCode"
        # "FiraMono"
        # "Hack"
        # "Inconsolata"
        # "Iosevka"
        "JetBrainsMono"
        # "Meslo"
        # "Noto"
        # "RobotoMono"
        # "Terminus"
        "Ubuntu"
      ];
    })
    dejavu_fonts
    roboto-serif
  ];
}
