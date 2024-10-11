{ pkgs, ... }:
{
  # nix-ld for handling dynamic lib
  enable = false;
  libraries = with pkgs; [
    glibc
    openssl
    gcc.cc.lib
  ];
}
