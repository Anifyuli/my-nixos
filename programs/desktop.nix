# desktop.nix for installing desktop environment.
{ config, pkgs, ... }:

{

  # Enable the X11 & XWayland windowing system.
  services.xserver.enable = true;
  programs.xwayland.enable = true;
  services.xserver.desktopManager.xterm.enable = false;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Exclude packages from the X server.
  services.xserver.excludePackages = [
    pkgs.xterm
  ];
 
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
        gnome-themes-extra
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
      dm-sans
      fira
      fira-code-nerdfont
      fira-code-symbols
      lato
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      open-sans
      roboto
      roboto-serif
      roboto-slab
      vistafonts
      work-sans
    ];
  };

  # Override default Dconf settings.
  services.xserver.desktopManager.gnome = { 
    extraGSettingsOverrides = ''
      [org.gnome.desktop.peripherals.touchpad]
      tap-to-click=true
    '';
    extraGSettingsOverridePackages = [
      pkgs.gsettings-desktop-schemas # for org.gnome.desktop
      pkgs.gnome.gnome-shell # for org.gnome.shell
    ];
  };
  
  # Enable ls colors in Bash
  programs.bash.enableLsColors = true;

}
