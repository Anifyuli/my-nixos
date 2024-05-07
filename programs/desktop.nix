{ pkgs, programs, services, ... }: {

  # Add fonts.
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      amiri
      corefonts
      clearlyU
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
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = "
    [org.gnome.desktop.peripherals.touchpad]
    tap-to-click=true
  ";
  
  # Enable ls colors in Bash
  programs.bash.enableLsColors = true;
}
