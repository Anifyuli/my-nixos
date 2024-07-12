{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # android-sdk
    # clang
    # cmake
    # ninja
    # pkg-config-unwrapped
    # android-studio
    # android-tools
    # flutter
  ];

  programs.adb.enable = true; 
}
