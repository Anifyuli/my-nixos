variables @ { pkgs, ... }:
{
  users.users = variables.customImport {
    folder = ./.;
    inherit variables;
  } {};
}
