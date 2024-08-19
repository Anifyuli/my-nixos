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
        # "0xProto"
        "3270"
        # "Agave"
        # "AnonymousPro"
        # "Arimo"
        # "AurulentSansMono"
        # "BigBlueTerminal"
        # "BitstreamVeraSansMono"
        # "CascadiaCode"
        # "CascadiaMono"
        # "CodeNewRoman"
        # "ComicShannsMono"
        # "CommitMono"
        # "Cousine"
        # "D2Coding"
        # "DaddyTimeMono"
        "DejaVuSansMono"
        # "DroidSansMono"
        # "EnvyCodeR"
        # "FantasqueSansMono"
        "FiraCode"
        # "FiraMono"
        # "GeistMono"
        # "Go-Mono"
        # "Gohu"
        # "Hack"
        # "Hasklig"
        # "HeavyData"
        # "Hermit"
        # "IBMPlexMono"
        # "Inconsolata"
        # "InconsolataGo"
        # "InconsolataLGC"
        # "IntelOneMono"
        # "Iosevka"
        # "IosevkaTerm"
        # "IosevkaTermSlab"
        "JetBrainsMono"
        # "Lekton"
        # "LiberationMono"
        # "Lilex"
        # "MPlus"
        # "MartianMono"
        # "Meslo"
        # "Monaspace"
        # "Monofur"
        # "Monoid"
        # "Mononoki"
        # "NerdFontsSymbolsOnly"
        # "Noto"
        # "OpenDyslexic"
        # "Overpass"
        # "ProFont"
        # "ProggyClean"
        # "Recursive"
        # "RobotoMono"
        # "ShareTechMono"
        # "SourceCodePro"
        # "SpaceMono"
        # "Terminus"
        # "Tinos"
        "Ubuntu"
        # "UbuntuMono"
        # "UbuntuSans"
        # "VictorMono"
        # "ZedMono"
        # "iA-Writer"
      ];
    })
    dejavu_fonts
    roboto-serif
  ];
}
