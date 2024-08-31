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

  kernelParams = [
    "zfs.zfs_arc_max=536870912" # max zfs cache (512MB)
  ];


  # Enable v4l2loopback kernel module for using Virtual Camera.
  extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="Virtual Camera" exclusive_caps=1
  '';

  kernel.sysctl = {
    # for unlimited warnet hack, thankxs to umahdroid.com
    # https://www.umahdroid.com/2023/08/trik-axis-warnet-unlimited-hotspot.html
    # "net.ipv4.ip_default_ttl" = 65;
    # "net.inet6.ip6.hlim" = 65;
  };
}
