{ pkgs, customImport, ... }:
{
  users.users = customImport {
    folder = ./.;
    variables = { inherit pkgs; };
  };
}
