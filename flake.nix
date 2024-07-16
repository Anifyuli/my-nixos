{
  description = "Mweheheheheheehehehehehe";

  # Inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-24_05.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-23_11.url = "github:NixOS/nixpkgs/nixos-23.11";
    fmpkgs = {
      url = "github:fmway/fmpkgs/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager.url = "github:nix-community/home-manager/master";
    fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
      inputs.nixpkgs.follows = "nixpkgs-23_11";
    };
    nixgl.url = "github:nix-community/NixGL";
  };

  outputs = { self, nixpkgs, nixos-hardware, fingerprint-sensor, nix-colors, home-manager, ... } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    fmchad = import ./fmchad.nix { inherit (nixpkgs) lib; };

    # Will be imported to configuration and home-manager
    specialArgs = fmchad // {
      inherit inputs outputs nix-colors system;
    };

    genericModules = [
      # add fmchad to overlays
      {
        nixpkgs.overlays = [
          (_: _: fmchad)
        ]
        ;
      }
      ./configuration.nix
      ./hardware-configuration.nix
      ./cachix.nix
      fingerprint-sensor.nixosModules.open-fprintd
      fingerprint-sensor.nixosModules.python-validity
      # {
      #   # Fix for nixpkgs without flakes
      #   nix.registry.nixos.flake = inputs.self;
      #   environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
      #   nix.nixPath = [ "nixpkgs=${nixpkgs.outPath}" ];
      # }
      # Home manager
      home-manager.nixosModules.home-manager
      {
        nix.registry.nixos.flake = inputs.self;
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = specialArgs;
        };
        imports = [
          ./home-manager
        ];
      } 
  ]; 

  in {
    nixosConfigurations = {
      Namaku1801 = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = genericModules ++ (fmchad.genDefaultImports ./.) ++ [
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
      };
    };
    packages.${system} = self.nixosConfigurations.Namaku1801.pkgs;
  };
}
