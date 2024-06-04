{
  services.xserver.enable = true;

  # GDM
  # services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Ly Display Manager
  services.xserver.displayManager.ly = {
    enable = true;
    defaultUser = "fmway";
  };

  # Keymap
  console.keyMap = "us";
  services.xserver.xkb = {
    layout = "us";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
}
