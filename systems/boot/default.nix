{ config, pkgs, customImportWithDefault, ... } @ variables:
customImportWithDefault {
  initial = {

    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="Virtual Camera" exclusive_caps=1
    '';
  };

  folder = ./.;
  excludes = [ "binfmt.nix" ];
  inherit variables;
}

