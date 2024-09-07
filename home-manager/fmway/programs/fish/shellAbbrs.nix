let
  with-cursor = str: {
    setCursor = "!";
    expansion = "${str}!";
  };
in {
  "lg" = "lazygit";

  ":id"   = with-cursor "trans :id '!'";
  "id:en" = with-cursor "trans id:en '!'";
  ":en"   = with-cursor "trans :en '!'";
  "en:id" = with-cursor "trans :en '!'";

  "y1080"= "yt-dlp -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]'";
  "y720" = "yt-dlp -f 'bestvideo[height<=720]+bestaudio/best[height<=720]'";
  "y480" = "yt-dlp -f 'bestvideo[height<=480]+bestaudio/best[height<=480]'";
  "y360" = "yt-dlp -f 'bestvideo[height<=360]+bestaudio/best[height<=360]'";
  "ytp"  = "yt-dlp --yes-playlist -o \"%(playlist)s/%(playlist_index)s. %(title)s.%(ext)s\" -f 'bestvideo[height<=480]+bestaudio/best[height<=480]'";
  "ytplaylist" = "yt-dlp --output '%(playlist_title)s/%(playlist_index)s. %(title)s.%(ext)s'";
  "m3v"  = "mpv --no-video";

  "nob"  = "nh os build /etc/nixos --verbose";
  "nobo" = "nh os boot /etc/nixos --verbose";
  "nos"  = "nh os switch /etc/nixos --verbose";

  "gclg"   = with-cursor "git clone https://github.com/!";
  "gclgl"  = with-cursor "git clone https://gitlab.com/!";
  "gclc"   = with-cursor "git clone https://codeberg.org/!";
  "gclsg"  = with-cursor "git clone git@github.com:!";
  "gcls"   = with-cursor "git clone git@!";
  "gclsgl" = with-cursor "git clone git@gitlab.com:!";
  "gclsc"  = with-cursor "git clone git@codeberg.org:!";
}
