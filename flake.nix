# flake.nix, NixOS configuration with Flakes
{
  description = "My NixOS configuration with Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # follow unstable channel
    nixpkgs-23-11.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware"; # NixOS hardware support
    home-manager.url = "github:nix-community/home-manager/master"; # Home Manager channel
    # Android tools Flakes
    android-nixpkgs = {
      url = "github:tadfisher/android-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
    # 06cb:009a fingerprint support Flakes
    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
      inputs.nixpkgs.follows = "nixpkgs-23-11";
    };
  };	

  outputs = { self, nixpkgs, nixos-hardware, home-manager, android-nixpkgs, nixos-06cb-009a-fingerprint-sensor, ... } @ inputs : let
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
      ./home-manager/home.nix # your home-manager config
    ];
  }

  # closure for adding overlays
  (_: {
   nixpkgs.overlays = [
      overlay-androidsdk
    ];
   })
  ];

  # list overlays 
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
          nixos-06cb-009a-fingerprint-sensor.nixosModules.open-fprintd
          nixos-06cb-009a-fingerprint-sensor.nixosModules.python-validity
        ];
      };
    };
  };
}
