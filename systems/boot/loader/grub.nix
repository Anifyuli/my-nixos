{ data, super, ... }:
{
  enable = ! super.systemd-boot.enable;
  copyKernels = true;
  # efiInstallAsRemovable = true;
  efiSupport = true;
  fsIdentifier = "label";
  device = "nodev";
  # Add chromeos
  extraEntries = data.chromeos-grub;
}
