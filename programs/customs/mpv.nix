{ super, self }: let
  
in super.mpv.override {
  scripts = with self.mpvScripts; [
    youtube-upnext
    webtorrent-mpv-hook
    visualizer
    sponsorblock
    # seekTo
    reload
    quality-menu
    quack
    mpv-playlistmanager
    autosubsync-mpv
    # mpv-osc-modern
    mpv-cheatsheet
    mpris
    # modernx
    memo
    thumbfast
    # manga-reader
    inhibit-gnome
    evafast
    uosc
  ];
}
