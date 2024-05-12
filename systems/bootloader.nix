{ config, ... }:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      # systemd-boot
      systemd-boot = {
        enable = true;
        memtest86.enable = true;
      };
      # grub
      # grub = {
      #   enable = true;
      #   copyKernels = true;
      #   # efiInstallAsRemovable = true;
      #   efiSupport = true;
      #   fsIdentifier = "label";
      #   device = "nodev";
      #   # Add chromeos
      #   extraEntries = ''
      #     ${lib.fileContents /chromeos.img.grub.txt}
      #   '';
      # };

      # timeout
      timeout = 3;
    };

    # plymouth
    plymouth = {
      enable = true;
      theme = "bgrt";
    };

    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="Virtual Camera" exclusive_caps=1
    '';
  };
}

