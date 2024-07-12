{ lib
, stdenv
, fetchFromGitHub
, cargo
, meson
, ninja
, pkg-config
, rustPlatform
, rustc
, wrapGAppsHook4
, cairo
, gdk-pixbuf
, glib
, gtk4
, libadwaita
, pango
, desktop-file-utils
, blueprint-compiler
} :

stdenv.mkDerivation rec {
  pname = "keypunch";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "bragefuglseth";
    repo = "keypunch";
    rev = "v${version}";
    hash = "sha256-S4RckHwrVVQrxy9QngTisNM4+cMM+1dXucwEDnM98Rg=";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-YzENAGy7zEu1dyuhme+x+gJQlE74Vw0JZvRso0vNQXs=";
  };

  nativeBuildInputs = [
    cargo
    meson
    ninja
    pkg-config
    rustPlatform.cargoSetupHook
    rustc
    wrapGAppsHook4
  ];

  buildInputs = [
    cairo
    gdk-pixbuf
    glib
    gtk4
    desktop-file-utils
    blueprint-compiler
    libadwaita
    pango
  ];

  meta = with lib; {
    description = "Practice your typing skills";
    homepage = "https://github.com/bragefuglseth/keypunch";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "keypunch";
    platforms = platforms.all;
  };
}
