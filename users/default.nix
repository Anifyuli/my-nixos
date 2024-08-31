{ pkgs, lib, ... }:
{
  users.users = lib.fmway.customImportWithDefault {
    folder = ./.;
    variables = {
      inherit pkgs lib;
    };
  };
}
