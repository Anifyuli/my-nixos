{ pkgs, ... }:
{
  # nix-ld for handling dynamic lib
  enable = true;
  libraries = with pkgs; [
    glibc
    openssl
    gcc.cc.lib
  ];
}
