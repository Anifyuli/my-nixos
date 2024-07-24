{ pkgs, config , programs, services, ... }: {

  system.fsPackages = [ pkgs.bindfs ];

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

  # packages
  environment.systemPackages = with pkgs; [
    nixgl.nixGLIntel
    niri
  ];

  # Add list DE
  services.displayManager.sessionPackages = with pkgs; [
    sway
    niri
  ];
  
  # Enable ls colors in Bash
  programs.bash.enableLsColors = true;
}
