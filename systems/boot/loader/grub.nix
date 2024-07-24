{ lib }:
{
  enable = true;
  copyKernels = true;
  # efiInstallAsRemovable = true;
  efiSupport = true;
  fsIdentifier = "label";
  device = "nodev";
  # Add chromeos
  extraEntries = ''
    ${lib.fileContents /chromeos.img.grub.txt}
  '';
}
