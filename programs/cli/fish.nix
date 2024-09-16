{ lib, ... }:
{
  enable = true;
  useBabelfish = true;
  interactiveShellInit = lib.fileContents ./interactive_config.fish;
}
