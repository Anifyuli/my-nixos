{ config, pkgs, lib, ... }:

{
  # Bootloader settings.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.memtest86.enable = true;
  
  # Plymouth for silent boot.
  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";
}
