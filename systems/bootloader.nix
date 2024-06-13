{ config, pkgs, lib, ... }:

{
  # Bootloader settings.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.memtest86.enable = true;
  
  # Plymouth for silent boot.
  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";

  # sysctl value
  boot.kernel.sysctl = {
    "kernel.printk" = "3 3 3 3";
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };
}
