{ pkgs, lib, customImport, genImportsWithDefault, ... }:
{
  imports = genImportsWithDefault ./.;

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
  ];

  # Exclude packages from the X server.
  services.xserver.excludePackages = [
    pkgs.xterm
  ];

  programs = let
    inherit (builtins) foldl';
    myImport = arr: obj: foldl' (acc: folder: customImport {
      inherit folder;
      variables = { inherit pkgs; };
      excludes = [ "nixvim.nix" "nix-ld.nix" ];
    } // acc) obj arr;

  in myImport [ ./cli ./gui ] {
 
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
