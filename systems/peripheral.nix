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
   sound.enable = false;
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
  
  # Enable v4l2loopback kernel module for using Virtual Camera in OBS Studio
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;
}
