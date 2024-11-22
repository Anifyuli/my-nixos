{ pkgs, ... }:
let
  inherit (pkgs) fetchurl;
in { packages = {
  # anytype = rec {
  #   version = "0.42.8";
  #   src = fetchurl {
  #     url = "https://github.com/anyproto/anytype-ts/releases/download/v${version}/Anytype-${version}.AppImage";
  #     hash = "sha256-MIPKfwIZQah6K+WOQZsTpVcOrws+f4oVa7BoW29K5BA=";
  #   };
  #   isElectron = true;
  #   extraPkgs = pkgs: [ pkgs.libsecret ];
  #   # x11Only = true;
  # };
  # bootstrap-studio = rec {
  #   version = "6.7.2";
  #   src = fetchurl {
  #     url = "https://releases.bootstrapstudio.io/${version}/Bootstrap%20Studio.AppImage";
  #     hash = "sha256-t75lmprCWumwt1wNVNWZSHdk1NBSmFqwjDQZHRpBv9g=";
  #   };
  # };
  # stayfree-desktop = rec {
  #   version = "2.6.10";
  #   src = fetchurl {
  #     url = "https://github.com/stayfree-app/desktop-releases/releases/download/v${version}/stayfree-linux-x86_64.AppImage";
  #     hash = "sha256-R4150TPr0RtcBIuy6w4ponQi4Dgteot+nz7HpK2hrRM=";
  #   };
  # };
  # popsql = {
  #   version = "1.0.129";
  #   src = fetchurl {
  #     url = "https://get.popsql.com/download/AppImage";
  #     hash = "sha256-Gwd4tZ0q1fYxumElqbzScrt+NWJDjc0xZtMx6JMLUVo=";
  #   };
  # };
}; }
