{
  SDL_VIDEODRIVER = "wayland";
  # needs qt5.qtwayland in systemPackages
  QT_QPA_PLATFORM = "wayland";
  QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
  # Fix for some Java AWT applications (e.g. Android Studio),
  # use this if they aren't displayed properly:
  _JAVA_AWT_WM_NONREPARENTING = 1;
}
