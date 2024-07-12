{ pkgs, lib, genImports, ... }:
{
  imports = genImports ./.;

  nixpkgs.config = {
    # allow unfree pkgs
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "genymotion"
        "spotify"
      ];

    # allow insecure packages
    permittedInsecurePackages = [
      "python3.12-youtube-dl-2021.12.17"
    ];
  };

  # List packages installed in the system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    cloudflare-warp
    # qemu with efi 
    (writeShellScriptBin "qemu-system-x86_64-uefi" ''
      qemu-system-x86_64 \
        -bios ${OVMF.fd}/FV/OVMF.fd \
        "$@"
    '')
    quickemu
    docker-compose
    distrobox
  ];

  # Exclude packages from the X server.
  services.xserver.excludePackages = [
    pkgs.xterm
  ];

  programs = {
 
    # Java
    # programs.java.enable = true;

    # Some programs need SUID wrappers, can be configured further or are started in user sessions.
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Add GSConnect connection configuration.
    kdeconnect.enable = true;
    kdeconnect.package = pkgs.gnomeExtensions.gsconnect;

  };

}
