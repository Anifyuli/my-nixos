{ config, pkgs,  ... }:

{
  imports = [
    ./bootloader.nix  # Bootloader & Plymouth
    ./graphic.nix     # Graphic processing
    ./network.nix     # Network
    ./peripheral.nix  # Peripheral
    ./timezone.nix    # Timezone & locales

  ];
}
