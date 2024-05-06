{ config, pkgs, ... }:

let
  android-nixpkgs = pkgs.callPackage <android-nixpkgs> {
  # Default; can also choose "beta", "preview", or "canary".
    channel = "stable";
};
  android-sdk = android-nixpkgs.sdk (sdkPkgs: with sdkPkgs; [
    cmdline-tools-latest
    build-tools-32-0-0
    platform-tools
    platforms-android-33
    emulator
    sources-android-33
  ]);
in {
  environment.systemPackages = with pkgs; [
    # Stable channel
    android-tools
    android-sdk
    clang
    cmake
    ninja
    pkg-config-unwrapped

    # Unstable channel 
    unstable.android-studio
    unstable.flutter
  ];
}
