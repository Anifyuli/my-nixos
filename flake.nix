# flake.nix, NixOS configuration with Flakes
{
  description = "My NixOS configuration with Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # NixOS unstable channel
    nixos-hardware.url = "github:NixOS/nixos-hardware"; # NixOS hardware support
    home-manager.url = "github:nix-community/home-manager/master"; # Home Manager channel
    android-nixpkgs = {
      url = "github:tadfisher/android-nixpkgs"; # Android tools Flakes
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };	

  outputs = { self, nixpkgs, nixos-hardware, home-manager, android-nixpkgs, ... } @ inputs : let
    inherit (self) outputs; # to export the output variable
    system = "x86_64-linux"; # your system
    genericModules = [
      ./configuration.nix
      {
    # Fix for nixpkgs without flakes
    nix.registry.nixos.flake = inputs.self;
    environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
    nix.nixPath = [ "nixpkgs=${nixpkgs.outPath}" ];
  }

  # Home manager
  home-manager.nixosModules.home-manager
  {
    nix.registry.nixos.flake = inputs.self;
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    imports = [
      ./modules/home # home-manager configs
    ];
  }

  # Closure for adding overlays
  (_: {
    nixpkgs.overlays = [
      overlay-androidsdk
    ];
  })
];

  # Overlays lists
  overlay-androidsdk = _final: _prev: {
    android-sdk = android-nixpkgs.sdk.${system} (sdkPkgs: with sdkPkgs; [
      cmdline-tools-latest
      build-tools-34-0-0
      platform-tools
      platforms-android-34
      emulator
    ]);
  };

  in
  {
    nixosConfigurations = {
        # Computer name (hostname)
        ThinkPad-X280 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs outputs; # Flakes can access inputs outputs in your configuration.nix, etc
          };
          modules = genericModules ++ [
            nixos-hardware.nixosModules.lenovo-thinkpad-x280
          ];
        };
      };
    };
  }
