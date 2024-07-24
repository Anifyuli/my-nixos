{ pkgs, ... }: (with pkgs.mpvScripts;
[
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
]) ++ [
  pkgs.fmpkgs.mpv-multiloop
]
