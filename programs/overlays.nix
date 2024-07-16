{ pkgs, inputs, system, lib, ... }:let
  nixpkgs-overlay = _final: _prev: let
    inherit (builtins) foldl' getAttr;
    overlayNixpkgs = arr: obj: foldl' (acc: curr: let
      name = "_${curr}";
      importName = getAttr "nixpkgs-${curr}" inputs;
    in {
      "${name}" = import importName {
        inherit system;
        config.allowUnfree = true;
      };
    } // acc) obj arr;
  in overlayNixpkgs [ "23_11" "24_05" "master" ] {
    fmpkgs = import inputs.fmpkgs {
      inherit system pkgs lib;
    };
  };

  custom-overlay = _final: prev: {
    custom = {
      git = prev.git.override { withLibsecret = true; };
    };
    json2nix = prev.writeScriptBin "json2nix" ''
      ${pkgs.python3}/bin/python ${prev.fetchurl {
        url = "https://gist.githubusercontent.com/Scoder12/0538252ed4b82d65e59115075369d34d/raw/e86d1d64d1373a497118beb1259dab149cea951d/json2nix.py";
        hash = "sha256-ROUIrOrY9Mp1F3m+bVaT+m8ASh2Bgz8VrPyyrQf9UNQ=";
      }} $@
    '';
  };

  package-overlay = self: super: self.customImport {
    folder = ./customs;
    variables = { inherit self super; };
    excludes = [
      "qutebrowser.nix"
    ];
  };  
in {
  nixpkgs.overlays = [
    nixpkgs-overlay
    custom-overlay
    package-overlay
    inputs.nixgl.overlay
  ];
}
