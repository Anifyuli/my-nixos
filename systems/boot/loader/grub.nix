{ data, super, ... }:
{
  enable = ! super.systemd-boot.enable;
  copyKernels = true;
  efiInstallAsRemovable = true;
  efiSupport = true;
  fsIdentifier = "label";
  zfsSupport = true;
  device = "/dev/disk/by-id/nvme-KINGSTON_OM8PDP3256B-AB1_50026B768583ADF8-part1";
  mirroredBoots = [
    { devices = [ "nodev" ]; path = "/boot"; }
  ];
  # device = "nodev";
  # Add chromeos
  extraEntries = data.chromeos-grub;
}
