{ pkgs, lib, genImports, ... }:
{
  imports = genImports ./.;

  # allow unfree pkgs
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "genymotion"
      "spotify"
    ];


  # List packages installed in the system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    cloudflare-warp
    # qemu with efi 
    (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
      qemu-system-x86_64 \
        -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
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
