{ lib
, fetchFromGitHub
, buildDotnetModule
}:
buildDotnetModule rec {
  pname = "xdm-app";
  version = "8.0.29";

  src = fetchFromGitHub {
    owner = "subhra74";
    repo = "xdm";
    rev = version;
    hash = "sha256-bdDiTwqsid+I2rsEYqcEOpvL9W3CwgAY0D1R837smdg=";
  };

  projectFile = "./app/XDM/XDM.App.Host/XDM.App.Host.csproj";

  nugetDeps = ./deps.nix;

  meta = with lib; {
    description = "Powerfull download accelerator and video downloader";
    homepage = "https://github.com/subhra74/xdm";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ ];
    mainProgram = "xdman";
    platforms = platforms.all;
  };
}
