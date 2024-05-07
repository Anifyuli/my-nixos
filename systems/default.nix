{...}: {
  imports = [
    ./env.nix
    ./security.nix
    ./bootloader.nix
    ./network.nix
    ./xserver.nix
    ./timezone.nix
    ./sound.nix
  ];
}
