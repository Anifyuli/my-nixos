{ self, super }: let
  pkgs = self;
in super.gnome.overrideScope (gself: gsuper: {
  nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
    buildInputs = nsuper.buildInputs ++ (with pkgs.gst_all_1; [
      gst-plugins-good
      gst-plugins-bad
    ]);
  });
}) 
