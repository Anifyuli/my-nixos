{
  "/yeah" = {
    device = "/dev/disk/by-label/HOME";
    fsType = "btrfs";
    options = [ "nofail" ];
  };

  "/home/fmway/assets" = {
    device = "/dev/disk/by-label/HOME";
    fsType = "btrfs";
    options = [ "subvol=@home/fmway" "nofail" ];
  };
}
