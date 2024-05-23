{ pkgs, config , programs, services, ... }: {

  system.fsPackages = [ pkgs.bindfs ];
  # Add fonts.
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      # amiri
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
