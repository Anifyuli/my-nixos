{ customImport, pkgs, ... } @ variables:
customImport {
  initial = {
    polkit = {
      enable = true;
    };

    # register package to pam services
    pam.services = {
      swaylock = {};
    };
  };
  folder = ./.;
  inherit variables;
}
