{
  "lg" = "lazygit";
  ":id" = {
    setCursor = "!";
    expansion = "trans :id '!'";
  };
  "id:en" = {
    setCursor = "!";
    expansion = "trans id:en '!'";
  };
  ":en" = {
    setCursor = "!";
    expansion = "trans :en '!'";
  };
  "en:id" = {
    setCursor = "!";
    expansion = "trans :en '!'";
  };
  "y1080" = "yt-dlp -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]'";
  "y720" = "yt-dlp -f 'bestvideo[height<=720]+bestaudio/best[height<=720]'";
  "y480" = "yt-dlp -f 'bestvideo[height<=480]+bestaudio/best[height<=480]'";
  "y360" = "yt-dlp -f 'bestvideo[height<=360]+bestaudio/best[height<=360]'";
  "ytp" = "yt-dlp --yes-playlist -o \"%(playlist)s/%(playlist_index)s. %(title)s.%(ext)s\" -f 'bestvideo[height<=480]+bestaudio/best[height<=480]'";
  "ytplaylist" = "yt-dlp --output '%(playlist_title)s/%(playlist_index)s. %(title)s.%(ext)s'";
  "m3v" = "mpv --no-video";
  "gclg" = {
    setCursor = "!";
    expansion = "git clone https://github.com/!";
  };
  "gclgl" = {
    setCursor = "!";
    expansion = "git clone https://gitlab.com/!";
  };
  "gclc" = {
    setCursor = "!";
    expansion = "git clone https://codeberg.org/!";
  };
  "gclsg" = {
    setCursor = "!";
    expansion = "git clone git@github.com:!";
  };
  "gcls" = {
    setCursor = "!";
    expansion = "git clone git@!";
  };
  "gclsgl" = {
    setCursor = "!";
    expansion = "git clone git@gitlab.com:!";
  };
  "gclsc" = {
    setCursor = "!";
    expansion = "git clone git@codeberg.org:!";
  };
}
