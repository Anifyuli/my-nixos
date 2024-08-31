{ self, super, ... }:
let
  src = super.cloudflare-warp;
in self.stdenv.mkDerivation {
  inherit (src) name pname version meta;
  inherit src;
  installPhase = ''
    mkdir $out
    cp -rf * $out/
    rm -rf $out/etc $out/lib
  ''; # remove autostart, very annoying
}
