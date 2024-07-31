{ pkgs, ... }: let
  encore-src = pkgs.fetchFromGitHub {
    name = "encore-source";
    owner = "encoredev";
    repo = "encore";
    rev = "v1.39.0";
    hash = "sha256-71vzo52vV4VilBnLZxIWDKIY08rfTavMZ57qgi4pip8=";
  };
in {
  runtimeEnv = {
    ENCORE_SRC = "${encore-src}"; 
  };

  runtimeInputs = with pkgs; [
    buf
  ];
}
