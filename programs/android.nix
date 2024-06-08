{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-studio
    android-tools
    clang
    cmake
    flutter
    ninja
    pkg-config-unwrapped
  ];
}
