{ lib
, stdenv
, coreutils
, binutils
, callPackage
}: let
  gendesk = callPackage ../gendesk { };
  xdm-app = callPackage ./xdm-app { };
  xdm-gtk = callPackage ./xdm-gtk { };
in stdenv.mkDerivation rec {
  pname = "xdman";
  version = "8.0.29";

  src = ./.;

  buildInputs = [
    gendesk
    binutils.bintools
    coreutils
  ];

  buildPhase = ''
    gendesk -f -n --name='Xtreme Download Manager' --comment="${meta.description}" --custom='Keywords=download;internet;manager;' --exec=$out/bin/xdman --icon=xdm-app --terminal=false --categories='Network' --startupnotify=false --pkgname=${pname}
      '';

  installPhase = ''
    mkdir -p $out/share/applications $out/bin $out/share/icons/hicolor/512x512/apps/ $out/share/icons/hicolor/scalable/apps
    ln -sv ${xdm-gtk}/bin/xdm-app $out/bin/${pname}
    install -m 644 ${xdm-gtk}/lib/xdm-gtk/xdm-logo-512.png $out/share/icons/hicolor/512x512/apps/xdm-logo.png
    install -m 644 ${xdm-gtk}/lib/xdm-gtk/xdm-logo-512.png $out/share/icons/hicolor/512x512/apps/xdm-app.png
    install -m 644 ${xdm-gtk}/lib/xdm-gtk/xdm-logo.svg $out/share/icons/hicolor/scalable/apps/xdm-logo.svg
    install -m 644 ${xdm-gtk}/lib/xdm-gtk/xdm-logo.svg $out/share/icons/hicolor/scalable/apps/xdm-app.svg
    install -m 644 ${pname}.desktop $out/share/applications/
  '';

  meta = with lib; {
    description = "Powerfull download accelerator and video downloader";
    homepage = "https://github.com/subhra74/xdm";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ ];
    mainProgram = "xdman";
    platforms = platforms.all;
  };
}
