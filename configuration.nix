## configuration.nix
{
  imports =
    [       
      ./hardware-configuration.nix # Include the results of the hardware scan
      ./modules # NixOS system configurations
    ];

  # Change nix.conf value
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.trusted-users = [
      "root"
      "anifyuli"
    ];
  };

  # Home Manager configurations
  home-manager.backupFileExtension = "backup";

  # NixOS version, change it if latest update released
  system.stateVersion = "unstable";
}
