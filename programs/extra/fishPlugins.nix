{ self, super, lib ? self.lib, ... }:
super.fishPlugins // {
  zoxide-fish = super.fishPlugins.buildFishPlugin {
    pname = "zoxide-fish";
    version = "unstable-2022-08-18";

    src = self.fetchFromGitHub {
      owner = "kidonng";
      repo = "zoxide.fish";
      rev = "bfd5947bcc7cd01beb23c6a40ca9807c174bba0e";
      hash = "sha256-Hq9UXB99kmbWKUVFDeJL790P8ek+xZR5LDvS+Qih+N4=";
    };

    meta = {
      description = "Fish plugin for zoxide";
      homepage = "https://github.com/kidonng/zoxide.fish";
      license = lib.licenses.mit;
      maintainers = [ ];
      platforms = lib.platforms.all;
    };
  };
}
