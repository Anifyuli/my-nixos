# https://get.popsql.com/download/AppImage
{ appimageTools
, fetchurl
, ... } :
let
  pname = "popsql";
  version = "1.0.129";
  src = fetchurl {
    url = "https://get.popsql.com/download/AppImage";
    hash = "sha256-Gwd4tZ0q1fYxumElqbzScrt+NWJDjc0xZtMx6JMLUVo=";
  };
  appimageContents = appimageTools.extract {
    inherit pname version src;
    postExtract = ''
      substituteInPlace $out/@popsqldesktop.desktop --replace 'Exec=AppRun' 'Exec=${pname}'
    '';
  };
in 
appimageTools.wrapType2 {
  inherit pname version src;
  extraPkgs = pkgs: with pkgs; [ ];
  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/@popsqldesktop.desktop $out/share/applications/@popsqldesktop.desktop
    cp -r ${appimageContents}/usr/share $out
  '';
}
