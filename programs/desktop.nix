# desktop.nix for installing desktop environment.
{ config, pkgs, ... }:

{

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Add fonts.
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      amiri
      corefonts
      clearlyU
      fira-code-nerdfont  
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      roboto
      roboto-serif
      vistafonts
    ];
  };

  # Override default Dconf settings.
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = "
    [org.gnome.desktop.peripherals.touchpad]
    tap-to-click=true
  ";
  
  # Enable ls colors in Bash
  programs.bash.enableLsColors = true;

}
