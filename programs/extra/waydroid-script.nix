{ self, super, ... }:
self.stdenv.mkDerivation {
  name = "waydroid-script";

  buildInputs = [
    (self.python3.withPackages(ps: with ps; [ tqdm requests inquirerpy ]))
  ];

  src = self.fetchFromGitHub {
    owner = "casualsnek";
    repo = "waydroid_script";
    rev = "1a2d3ad643206ad5f040e0155bb7ab86c0430365";
    hash = "sha256-OiZO62cvsFyCUPGpWjhxVm8fZlulhccKylOCX/nEyJU=";
  };

  postPatch = ''
    patchShebangs main.py
  '';

  installPhase = ''
    mkdir -p $out/libexec
    cp -r . $out/libexec/waydroid_script
    mkdir -p $out/bin
    ln -s $out/libexec/waydroid_script/main.py $out/bin/waydroid_script
  '';
}
