# overrides.nix for declare overrided packages
{config, pkgs, ...}:
{
  # Nautilus overlay for show better audio & video metadata
  nixpkgs.overlays = [(self: super: {
    gnome = super.gnome.overrideScope' (gself: gsuper: {
      nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
        buildInputs = nsuper.buildInputs ++ (with pkgs.gst_all_1; [
          gst-plugins-good
          gst-plugins-bad
        ]);
      });
    });
  })];
  
  # Change yt-dlp to youtube-dl
  nixpkgs.config.permittedInsecurePackages = [
    "python3.12-youtube-dl-2021.12.17"
  ];

}
