# peripheral.nix for configuring other peripheral related like audio, input, etc.
{config, pkgs, ...}:

{

  # Configure keymap in X11.
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  # Configure console keymap.
  console.keyMap = "uk";

  # Enable CUPS to document printings.
  services.printing.enable = true;

   # Enable sound with pipewire.
   sound.enable = true;
   hardware.pulseaudio.enable = false;
   security.rtkit.enable = true;
   services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
 
}
