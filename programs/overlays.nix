{ pkgs, inputs, system, ... }:let
  gnome-overlay = self: super: {
    gnome = super.gnome.overrideScope' (gself: gsuper: {
      nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
        buildInputs = nsuper.buildInputs ++ (with pkgs.gst_all_1; [
          gst-plugins-good
          gst-plugins-bad
        ]);
      });
    });
  };
  stable-overlay = _final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  };

  custom-overlay = _final: _prev: {
    custom = import ./customs {
      inherit pkgs;
    };
  };

in {
  nixpkgs.overlays = [
    gnome-overlay
    stable-overlay
    custom-overlay
    inputs.nixgl.overlay
  ];
}
