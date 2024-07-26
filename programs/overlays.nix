{ pkgs, config, inputs, customImport, excludeItems, treeImport, basename, getNixs, system, lib, ... } @ variables: let
  inherit (lib) warn recursiveUpdate;
  inherit (builtins) readFile attrNames foldl' getAttr pathExists listToAttrs map isAttrs isFunction isString;
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

  scripts-overlay = final: prev: {
    scripts = let
      files = getNixs ./scripts;
      result = map (file: let
        imported = import (./scripts + "/${file}");
        context = if isFunction imported then
            imported variables
          else imported;
        name = basename file;
        value = 
          if isString context then 
            prev.writeScriptBin name context 
          else if isAttrs context then
            prev.writeShellApplication (recursiveUpdate { 
              inherit name;
              text = if pathExists (./scripts + "/${name}.sh") then
                  readFile (./scripts + "/${name}.sh")
                else "echo ${name} executed";
            } context)
          else if isFunction context then let
            function = runtimeInputs: text:
              prev.writeShellApplication { 
                inherit name runtimeInputs text;
              };
          in context function
          else throw "${file} is not like scripts :)";
      in {
        inherit name value;
      }) files;
    in listToAttrs result;
  };

  package-overlay = self: super: treeImport {
    folder = ./customs;
    variables = { inherit self super pkgs inputs lib config; };
    depth = 0;
    excludes = [
      "qutebrowser"
    ];
  } (let
    fmchad = import ../fmchad.nix {
      inherit lib pkgs;
    };
    names = attrNames fmchad;
  in foldl' (acc: key: {
    "${key}" = warn "${key} is moved to functions.${key}" fmchad.${key};
  } // acc) { functions = fmchad; } names);
in {
  nixpkgs.overlays = [
    inputs.agenix.overlays.default
    nixpkgs-overlay
    scripts-overlay
    package-overlay
    inputs.nixgl.overlay
  ];
}
