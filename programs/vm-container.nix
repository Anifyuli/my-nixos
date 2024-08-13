{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    # qemu with efi 
    (writeShellScriptBin "qemu-system-x86_64-uefi" ''
      qemu-system-x86_64 \
        -bios ${OVMF.fd}/FV/OVMF.fd \
        "$@"
    '')
    # quickemu
    docker-compose
    distrobox
  ];
  
  # register all user to VirtualBox group 
  users.extraGroups.vboxusers.members = config.data.list-users;

  # Podman configurations
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };

    docker.enable = true;
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    virtualbox = {
      host = {
        enable = true;
        package = pkgs.virtualbox;
      };
      guest.enable = true;
    };

    # waydroid.enable = true;
  };
}
