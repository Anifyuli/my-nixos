{ self, super }:
# obs with plugins
super.wrapOBS {
  plugins = with self.obs-studio-plugins; [
    wlrobs
    obs-backgroundremoval
    obs-pipewire-audio-capture
  ];
}
