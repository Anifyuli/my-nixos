{ pkgs
, config
, inputs
, outputs
, treeImport
, system
, lib
, ...
}: let
  inherit (lib) warn;
  inherit (builtins) attrNames foldl' getAttr;
  nixpkgs-overlay = self: super: let
    overlayNixpkgs = arr: obj: foldl' (acc: curr: let
      name = "_${curr}";
      importName = getAttr "nixpkgs-${curr}" inputs;
    in {
      "${name}" = import importName {
        inherit system;
        config.allowUnfree = true;
      };
    } // acc) obj arr;
  in overlayNixpkgs [ "23_11" "24_05" ] {
    fmpkgs = import inputs.fmpkgs {
      inherit system pkgs lib;
    };
    nur = import inputs.nur {
      nurpkgs = self;
    };
    extra = inputs.nixpkgs-extra.packages.${system};
  };

  package-overlay = self: super: treeImport
  (let
    functions = outputs.fmchad;
    names = attrNames functions;
  in foldl' (acc: key:
  {
    "${key}" = warn "${key} is moved to functions.${key}" functions.${key};
  } // acc) { inherit functions; } names)
  {
    folder = ./extra;
    variables = { inherit self super pkgs inputs lib config; };
    depth = 0;
    excludes = [
      "qutebrowser"
    ];
  };
in {
  nixpkgs.overlays = [
    inputs.agenix.overlays.default
    nixpkgs-overlay
    package-overlay
    inputs.nixgl.overlay
  ];
}
