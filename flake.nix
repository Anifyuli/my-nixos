{
  description = "Mweheheheheheehehehehehe";

  # Inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/master";
    fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nixgl.url = "github:nix-community/NixGL";
  };

  outputs = { self, nixpkgs, nixos-hardware, fingerprint-sensor, home-manager, nixpkgs-stable, ... } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    genericModules = [
      ./configuration.nix
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
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        imports = [
          ./home-manager
        ];
      } 
    ]; 

  in {
    nixosConfigurations = {
      Namaku1801 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs system;
        };
        modules = genericModules ++ [
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
      };
    };
    packages.${system} = let
      pkgs = nixpkgs.legacyPackages.${system};
    in import ./programs/customs { inherit pkgs; };
  };
}
