{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    # Stable channel
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
