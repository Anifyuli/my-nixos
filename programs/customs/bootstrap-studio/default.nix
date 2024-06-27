{ appimageTools
, fetchurl
, ... } :
let
  pname = "bootstrap-studio";
  version = "6.7.2";
  src = fetchurl {
    url = "https://releases.bootstrapstudio.io/${version}/Bootstrap%20Studio.AppImage";
    hash = "sha256-t75lmprCWumwt1wNVNWZSHdk1NBSmFqwjDQZHRpBv9g=";
  };
  appimageContents = appimageTools.extract {
    inherit pname version src;
    postExtract = ''
      substituteInPlace $out/bstudio.desktop --replace 'Exec=AppRun' 'Exec=${pname}'
    '';
  };
in 
appimageTools.wrapType2 {
  inherit pname version src;
  extraPkgs = pkgs: with pkgs; [ ];
  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/bstudio.desktop $out/share/applications/bstudio.desktop
    install -m 444 -D ${appimageContents}/bstudio.png \
      $out/share/icons/hicolor/512x512/apps/bstudio.png
  '';
}
