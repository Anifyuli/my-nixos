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

  # Enable Podman
  #virtualisation.podman = {
  #  dockerCompat = true;
  #  dockerSocket.enable = true;
  #  enable = true;
  #};
}
