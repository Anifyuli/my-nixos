# { pkgs, ... }:
let
  # inherit (pkgs)
  #   fetchurl
  # ;
in {
  enable = true;
  packages = {
    # zen-browser = rec {
    #   version = "1.0.0-a.28";
    #   src = fetchurl {
    #     url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen-specific.AppImage";
    #     hash = "sha256-S49M3QVpjQ36+f4xeC13XXn11IlzHmTvfIZkTS/YOF4=";
    #   };
    # };
  };
}
