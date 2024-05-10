# virtualization.nix for virtualization & container configurations
{config, pkgs,  ...}:

{
  # Podman configurations
  # Enable common container config files in /etc/containers
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # VirtualBox virtualization support
  users.extraGroups.vboxusers.members = [ "anifyuli" ];
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.host.package = pkgs.virtualbox;
}
