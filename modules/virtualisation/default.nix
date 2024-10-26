{pkgs,  ...}:

{
  # VirtualBox virtualisation support
  virtualisation.virtualbox = {
    host = {
      enable = true;
      package = pkgs.virtualbox;
    };
    guest.enable = true;
  };

  # Enable Docker virtualisation support
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Enable Podman
  virtualisation.podman = {
    enable = true;
  };
}
