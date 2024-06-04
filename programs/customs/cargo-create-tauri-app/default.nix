{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage rec {
  pname = "create-tauri-app";
  version = "4.0.0";

  src = fetchFromGitHub {
    owner = "tauri-apps";
    repo = "create-tauri-app";
    rev = "create-tauri-app-v${version}";
    hash = "sha256-OfW4v+QngkcJ0HBO3R288jm6KNNQ2sMMFliWYrDPvtQ=";
  };

  cargoHash = "sha256-3Ep8wZzhHoC5iqXtZmzKKcFkdrK7SLKOOOTBk0l1dus=";

  meta = with lib; {
    description = "Rapidly scaffold out a new tauri app project";
    homepage = "https://github.com/tauri-apps/create-tauri-app";
    changelog = "https://github.com/tauri-apps/create-tauri-app/blob/${src.rev}/CHANGELOG.md";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ ];
    mainProgram = "create-tauri-app";
  };
}
