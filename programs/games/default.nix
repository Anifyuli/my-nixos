{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # steamcmd
    # steam-tui
  ];

  # required for steam gamescope
  programs.gamescope = lib.mkIf config.programs.steam.enable {
    enable = true;
    capSysNice = true;
  };
}
