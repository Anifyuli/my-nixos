{ pkgs, config , programs, services, ... }: {

  # bindfs for Flatpak fonts & icons integration.
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregatedIcons = pkgs.buildEnv {
      name = "system-icons";
      paths = with pkgs; [
        #libsForQt5.breeze-qt5  # for plasma
        gnome.gnome-themes-extra
      ];
      pathsToLink = [ "/share/icons" ];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.packages;
      pathsToLink = [ "/share/fonts" ];
    };
  in {
    "/usr/share/icons" = mkRoSymBind "${aggregatedIcons}/share/icons";
    "/usr/local/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
  };


  # Add fonts.
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      amiri
      corefonts
      # clearlyU
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      roboto
      nerdfonts
      dejavu_fonts
      roboto-serif
    ];
  };

  # Override default Dconf settings.
  services.xserver.desktopManager.gnome = {
    extraGSettingsOverrides = "
      [org.gnome.desktop.peripherals.touchpad]
      tap-to-click=true
    ";
    extraGSettingsOverridePackages = [
      pkgs.gsettings-desktop-schemas # for org.gnome.desktop
      pkgs.gnome.gnome-shell # for org.gnome.shell
    ];
  };

  # Add list DE
  services.displayManager.sessionPackages = with pkgs; [
    sway
  ];
  
  # Enable ls colors in Bash
  programs.bash.enableLsColors = true;
}
