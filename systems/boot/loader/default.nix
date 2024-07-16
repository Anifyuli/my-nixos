{ pkgs, lib, customImport ? pkgs.customImport, ... } @ variables:
customImport {
  initial = {
    efi.canTouchEfiVariables = true;
    # timeout
    timeout = 3;
  };
  
  folder = ./.;
  excludes = [ "grub.nix" ];
  inherit variables;
}
