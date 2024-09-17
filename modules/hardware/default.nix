{ config, pkgs, ... }:

{
  # Bluetooth configurations
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;

  # Enable sound with pipewire
  hardware.pulseaudio.enable = false;
}
