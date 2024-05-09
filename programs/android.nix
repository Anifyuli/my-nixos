{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Stable channel
    android-sdk
    clang
    cmake
    ninja
    pkg-config-unwrapped

    # Unstable channel 
    unstable.android-studio
    unstable.android-tools
    unstable.flutter
  ];
}
