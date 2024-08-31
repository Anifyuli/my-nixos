{ pkgs
, config
, root-path
, inputs
, outputs
, system
, lib
, ...
} @ variables
: let
  inherit (lib.fmway)
    treeImport
  ;
  inherit (builtins) 
    foldl'
    getAttr
    ;
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
    # nur = import inputs.nur {
    #   nurpkgs = self;
    # };
    extra = inputs.nixpkgs-extra.packages.${system};
  };

  package-overlay = self: super: treeImport {
    folder = ./extra;
    variables = variables // { inherit self super; };
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
    inputs.nur.overlay
    inputs.nixgl.overlay
  ];
}
