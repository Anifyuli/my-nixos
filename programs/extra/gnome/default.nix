{ super, self, pkgs }: let
in super.gnome.overrideScope (gself: gsuper: {
  nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
    buildInputs = nsuper.buildInputs ++ (with pkgs.gst_all_1; [
      gst-plugins-good
      gst-plugins-bad
    ]);
  });
  # gdm with background
  # place your background to /etc/current-background
  gnome-shell = gsuper.gnome-shell.overrideAttrs (old: {
    patches = (old.patches or []) ++ [
      ./bg.patch
    ];
  });
})
