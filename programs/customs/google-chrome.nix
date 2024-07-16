{ self, super }:
# Google chrome with wayland support
super.google-chrome.override {
  commandLineArgs = [
    "--enable-features=VaapiVideoDecodeLinuxGL,TouchpadOverscrollHistoryNavigation"
    "--use-gl=angle"
    "--use-angle=gl"
    "--ozone-platform=wayland"
  ];
}
