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
    "kernel.sysrq" = 1;
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };

  # Enable v4l2loopback kernel module for using Virtual Camera.
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="Virtual Camera" exclusive_caps=1
  '';
}
