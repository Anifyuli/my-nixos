{ pkgs, lib, getNixs, customImport, basename, genImportsWithDefault, ... } @ variables:
{
  imports = genImportsWithDefault ./. [ "customs" ];

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
  environment.systemPackages = (with pkgs; [
    cloudflare-warp
    scrcpy
    wl-clipboard
  ]) ++ (map (x: let # install all package in ./scripts
    name = basename x;
    pkg = pkgs.scripts.${name};
  in pkg) (getNixs ./scripts));

  # Exclude packages from the X server.
  services.xserver.excludePackages = [
    pkgs.xterm
  ];

  programs = customImport {
    folder = [ ./cli ./gui ];
    excludes = [ "nixvim.nix" "nix-ld.nix" ];
    inherit variables;
  } {
 
    # Some programs need SUID wrappers, can be configured further or are started in user sessions.
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    
    # enable fish
    fish.enable = true;
  };
}
