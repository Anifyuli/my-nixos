{ pkgs, ... }:
{

  # Override default Dconf settings.
  services.xserver.desktopManager.gnome = {
    extraGSettingsOverrides = "
      [org.gnome.desktop.peripherals.touchpad]
      tap-to-click=true
    ";
    extraGSettingsOverridePackages = with pkgs;[
      gsettings-desktop-schemas # for org.gnome.desktop
      gnome-shell # for org.gnome.shell
    ];
  };

  # packages
  environment.systemPackages = with pkgs; [
    nixgl.nixGLIntel
    adw-gtk3
  ];

  # Add list DE
  services.displayManager.sessionPackages = with pkgs; [
    sway
    niri
  ];
  
  # Enable ls colors in Bash
  programs.bash.enableLsColors = true;
}
