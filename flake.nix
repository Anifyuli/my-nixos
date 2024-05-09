# flake.nix, NixOS configuration with Flakes
{
  description = "My NixOS configuration with Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11"; # stable channel
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; # unstable channel
    nixos-hardware.url = "github:NixOS/nixos-hardware"; # NixOS hardware support
    home-manager.url = "github:nix-community/home-manager/release-23.11"; # follow Home Manager latest stable channel
    android-nixpkgs = {
      url = "github:tadfisher/android-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };	

  outputs = { self, nixpkgs, nixos-hardware, home-manager, android-nixpkgs, nixpkgs-unstable, ... } @ inputs: let
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
      ./home-manager/home-manager.nix # your home-manager config
    ];
  }
  # closure for adding overlays
  (_: {
   nixpkgs.overlays = [
      overlay-unstable
      overlay-androidsdk
    ];
   })
  ];
  # list overlays 
  # unstable overlay
    overlay-unstable = _final: _prev: {
      # it will be access in pkgs.unstable
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
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
        # Your Computer name (hostname)
        ThinkPad-X280 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs; # so you can access inputs outputs in your configuration.nix, etc
        };
        modules = genericModules ++ [
          nixos-hardware.nixosModules.lenovo-thinkpad-x280
        ];
      };
    };
  };
}
