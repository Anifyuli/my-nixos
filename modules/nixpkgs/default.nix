{ pkgs, ... }:

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

    # Adw-gtk3 pinning version to 5.3
    (final: prev: {
      adw-gtk3 = prev.adw-gtk3.overrideAttrs (old: rec {
        version = "5.3";
        src = final.fetchFromGitHub {
          owner = "lassekongo83";
          repo = "adw-gtk3";
          rev = "v${version}";
          hash = "sha256-DpJLX9PJX1Q8dDOx7YOXQzgNECsKp5uGiCVTX6iSlbI=";
        };
      });
    })
  ];

  # Change yt-dlp to youtube-dl
  nixpkgs.config.permittedInsecurePackages = [
    "python3.12-youtube-dl-2021.12.17"
  ];
}
