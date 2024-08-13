{ pkgs, ... }: let
  inherit (pkgs)
    fetchFromGitHub
  ;
in {
  aliases = {
    e = "edit";
    filter = "scout -prts";
    setl = "setlocal";
  };
  plugins = [
  rec {
    name = "ranger-archives";
    src = fetchFromGitHub {
      owner = "maximtrp";
      repo = name;
      rev = "master";
      hash = "sha256-QJu5G2AYtwcaE355yhiG4wxGFMQvmBWvaPQGLsi5x9Q=";
    };
  }
  ];
}
