{ super, self, ... }:
{
  git = super.git.override { withLibsecret = true; };
  cloudflare-warp = let
    cw = self.cloudflare-warp;
  in self.stdenv.mkDerivation {
    inherit (cw) name pname version meta;
    src = cw;
    installPhase = ''
      mkdir $out
      cp -rf * $out/
      rm -rf $out/etc $out/lib
    ''; # remove autostart, very annoying
  };
  obs-studio = self.wrapOBS {
    plugins = with self.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
