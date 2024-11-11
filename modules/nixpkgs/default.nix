
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Derivation overlays
  nixpkgs.overlays = [

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
