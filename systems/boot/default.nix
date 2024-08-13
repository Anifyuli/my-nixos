{ config, ... }:
{
  plymouth = {
    enable = true;
    theme = "bgrt";
  };
  tmp = {
    cleanOnBoot = true;
    useTmpfs = true;
  };
  # Enable v4l2loopback kernel module for using Virtual Camera.
  extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="Virtual Camera" exclusive_caps=1
  '';
}
