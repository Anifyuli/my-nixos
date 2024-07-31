{ pkgs, ... } @ variables:
{
  users.users = variables.customImport {
    folder = ./.;
    inherit variables;
  };
}
