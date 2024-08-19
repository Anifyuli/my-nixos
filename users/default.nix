{ pkgs, lib, customImport, ... } @ variables: {
  users.users = customImport {
    folder = ./.;
    inherit variables;
  };
}
