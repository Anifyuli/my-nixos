{
  remotes = [
    { name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
    { name = "flathub-beta"; location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo"; }
  ];
  packages = [];
  update.auto = {
    enable = true;
    onCalendar = "weekly"; # Default value
  };

  # overrides = {
    # global = {
      # Force Wayland by default
      # Context.sockets = ["wayland" "!x11" "!fallback-x11"];

      # Environment = {
        # Fix un-themed cursor in some Wayland apps
        # XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

        # Force correct theme for some GTK apps
        # GTK_THEME = "Adwaita:dark";
      # };
    # };

    # "com.visualstudio.code".Context = {
    #   filesystems = [
    #     "xdg-config/git:ro" # Expose user Git config
    #     "/run/current-system/sw/bin:ro" # Expose NixOS managed software
    #   ];
    #   sockets = [
    #     "gpg-agent" # Expose GPG agent
    #     "pcsc" # Expose smart cards (i.e. YubiKey)
    #   ];
    # };

    # "org.onlyoffice.desktopeditors".Context.sockets = ["x11"]; # No Wayland support
  # };
}
