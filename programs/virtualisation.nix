# virtualization.nix for virtualisation & container configurations
{config, pkgs,  ...}:

{
  # VirtualBox virtualisation support
  users.extraGroups.vboxusers.members = [ "anifyuli" ];
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
}
