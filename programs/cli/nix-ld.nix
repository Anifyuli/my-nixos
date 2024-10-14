{ pkgs, ... }:
{
  # nix-ld for handling dynamic lib
  enable = true;
  libraries = with pkgs; [
    glibc
    openssl
    stdenv.cc.cc
    # gcc.cc.lib
    clang.cc.lib
  ];
}
