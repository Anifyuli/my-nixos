{ config, pkgs,  ... }:

{
  imports = [
    ./bootloader.nix  # Bootloader & Plymouth
    ./network.nix     # Network
    ./peripheral.nix  # Peripheral
    ./timezone.nix    # Timezone & locales
  ];
}
