{ config, ... }:
with config.boot.loader; {
  enable = ! systemd-boot.enable;
  copyKernels = true;
  efiInstallAsRemovable = ! efi.canTouchEfiVariables;
  efiSupport = true;
  fsIdentifier = "label";
  zfsSupport = true;
  # device = "/dev/disk/by-id/nvme-KINGSTON_OM8PDP3256B-AB1_50026B768583ADF8-part1";
  mirroredBoots = [
    { devices = [ "nodev" ]; path = "/boot"; }
  ];
  device = "nodev";
}
