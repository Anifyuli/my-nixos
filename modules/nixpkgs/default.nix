{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Derivation overlays
  nixpkgs.overlays = [
    # Nautilus overlay for show better audio & video metadata
    (self: super: {
      gnome = super.gnome.overrideScope(gself: gsuper: {
        nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
          buildInputs = nsuper.buildInputs ++ (with pkgs.gst_all_1; [
            gst-plugins-good
            gst-plugins-bad
          ]);
        });
      });
    })


    # VS Code overlay for fix X11 color profile to sRGB
    (final: prev: {
      vscode = prev.vscode.override {
        commandLineArgs = ''--force-color-profile=srgb'';
      };
    })
  ];

  # Change yt-dlp to youtube-dl
  nixpkgs.config.permittedInsecurePackages = [
    "python3.12-youtube-dl-2021.12.17"
  ];
}
