{ pkgs, customImport, ... }:
{
  programs = customImport {
    folder = ./.;
    variables = { inherit pkgs; };
    initial = {
      # Let Home Manager install and manage itself.
      home-manager.enable = true;
    };
  };
}
