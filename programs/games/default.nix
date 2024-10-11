{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    steamcmd
    steam-tui
  ];

  # required for steam gamescope
  programs.gamescope = {
    enable = lib.mkIf config.programs.steam.enable true;
    capSysNice.enable = lib.mkIf config.programs.steam.enable true;
  };
}
