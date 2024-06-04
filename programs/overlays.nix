{ pkgs, inputs, system, lib, getDefaultNixs, ... }:let
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
  stable-overlay = _final: _prev: {
    _23_11 = import inputs.nixpkgs-23_11 {
      inherit system;
      config.allowUnfree = true;
    };
    _24_05 = import inputs.nixpkgs-24_05 {
      inherit system;
      config.allowUnfree = true;
    };
  };

  custom-overlay = _final: _prev: {
    custom = builtins.foldl' (acc: curr: {
        "${curr}" = pkgs.callPackage (lib.path.append ./customs curr) { };
      } // acc) {} (getDefaultNixs ./customs);
  };

in {
  nixpkgs.overlays = [
    gnome-overlay
    stable-overlay
    custom-overlay
    inputs.nixgl.overlay
  ];
}
