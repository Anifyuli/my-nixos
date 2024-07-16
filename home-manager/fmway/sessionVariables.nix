{ pkgs, home, user, ... }:
{
  ASSETS = "${home}/assets";
  GITHUB = "${home}/assets/Github";
  PL = "${home}/assets/pl";
  PROJECTS = "${home}/assets/Projects"; 
} // (pkgs.getEnv user)
