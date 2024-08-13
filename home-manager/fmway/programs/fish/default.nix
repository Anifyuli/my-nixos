{
  shellAliases = {
    "lg" = "lazygit";
    ":id" = "trans :id";
    "id:en" = "trans id:en";
    ":en" = "trans :en";
    "en:id" = "trans en:id";
    "rkol" = "set_color -o (tr -dc 'A-Fa-f0-9' </dev/urandom | head -c 6 ; echo)";
    ":q" = "exit";
    ":q!" = "exit";
    "..." = "cd ../..";
    keypresscode = "xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\\n\", $5, $8 }'";
    urldecode = "sed \"s@+@ @g;s@%@\\\\x@g\" | xargs -0 printf \"%b\"";
    "y1080" = "yt-dlp -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]'";
    "y720" = "yt-dlp -f 'bestvideo[height<=720]+bestaudio/best[height<=720]'";
    "y480" = "yt-dlp -f 'bestvideo[height<=480]+bestaudio/best[height<=480]'";
    "y360" = "yt-dlp -f 'bestvideo[height<=360]+bestaudio/best[height<=360]'";
    "ytp" = "yt-dlp --yes-playlist -o \"%(playlist)s/%(playlist_index)s. %(title)s.%(ext)s\" -f 'bestvideo[height<=480]+bestaudio/best[height<=480]'";
    "ytplaylist" = "yt-dlp --output '%(playlist_title)s/%(playlist_index)s. %(title)s.%(ext)s'";
    "mpyt" = "mpv --no-video";
  };
  interactiveShellInit = ''
    set fish_greeting # Disable greeting
    starship init fish | source
    direnv hook fish | source
    printf '\e[5 q'
  '';
}
