{ pkgs
, lib
, config
, customImport
, genImportsWithDefault'
, ...
} @ variables:

{
  imports = genImportsWithDefault' ./. [ "extra" ];

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
    # cloudflare-warp
    scrcpy
    wl-clipboard
  ]);

  # Exclude packages from the X server.
  services.xserver.excludePackages = [
    pkgs.xterm
  ];


  programs = customImport
  { 
    # Some programs need SUID wrappers, can be configured further or are started in user sessions.
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # nh is nixos-rebuild / nix build with beautiful output
    nh = {
      enable = true;
      flake = "/etc/nixos";
    };

    # allow fuse in user mode
    fuse.userAllowOther = true;

    # enable cloudflared
    cloudflared = {
      enable = true;
      secretFile = config.age.secrets.cloudflared.path;
    };

    # enable scripts
    script.enable = true;
    script.cwd = ./scripts;
    
    # enable fish
    fish.enable = true;
  }
  {
    folder = [ ./cli ./gui ];
    excludes = [ "nixvim.nix" "nix-ld.nix" ];
    inherit variables;
  };
}
