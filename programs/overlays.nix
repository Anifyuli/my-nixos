{ pkgs, inputs, system, lib, getDefaultNixs, getNixs, basename, genImports, ... }:let
  gnome-overlay = self: super: {
    gnome = super.gnome.overrideScope (gself: gsuper: {
      nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
        buildInputs = nsuper.buildInputs ++ (with pkgs.gst_all_1; [
          gst-plugins-good
          gst-plugins-bad
        ]);
      });
    });
  };
  nixpkgs-overlay = _final: _prev: {
    _23_11 = import inputs.nixpkgs-23_11 {
      inherit system;
      config.allowUnfree = true;
    };
    _24_05 = import inputs.nixpkgs-24_05 {
      inherit system;
      config.allowUnfree = true;
    };
    _master = import inputs.nixpkgs-master {
      inherit system;
      config.allowUnfree = true;
    };
  };

  custom-overlay = _final: _prev: {
    custom = builtins.foldl' (acc: curr: {
        "${curr}" = pkgs.callPackage (lib.path.append ./customs curr) { };
      } // acc) {} (getDefaultNixs ./customs);
  };

  custom-closure = _final: _prev: rec {
    inherit getDefaultNixs getNixs genImports basename;
    readEnv = file: builtins.foldl' (acc: curr: {
      "${builtins.elemAt curr 0}" = "${builtins.elemAt curr 1}";
    } // acc) {} (
      builtins.map (x: builtins.elemAt (builtins.split "^([^= ]+)=(.*)$" x) 1) (builtins.filter (x: x != "") (lib.splitString "\n" (builtins.readFile file)))); # Just to parse .env file to mapAttrs
    getEnv = entity: readEnv (lib.path.append ../secrets "${entity}.env");
  };

  package-overlay = final: prev: {
    qutebrowser = prev.qutebrowser.override { enableWideVine = true; }; 
  };

in {
  nixpkgs.overlays = [
    gnome-overlay
    nixpkgs-overlay
    custom-closure
    custom-overlay
    package-overlay
    inputs.nixgl.overlay
  ];
}
