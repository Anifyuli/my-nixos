let
  yeah = let
    device = "/dev/disk/by-label/HOME";
    fsType = "btrfs";
  in {
    "/yeah" = {
      inherit device fsType;
      options = [ "nofail" "compress=zstd" ];
    };

    "/home/fmway/assets" = {
      inherit device fsType;
      options = [ "subvol=@home/fmway" "nofail" "compress=zstd" ];
    };
  };
in yeah
