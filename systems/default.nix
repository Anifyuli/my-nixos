{...}: {
  imports = [
    ./env.nix
    ./security.nix
    ./boot.nix
    ./network.nix
    ./xserver.nix
    ./timezone.nix
    ./sound.nix
  ];
}
