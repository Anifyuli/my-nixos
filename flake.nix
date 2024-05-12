{
  description = "Mweheheheheheehehehehehe";

  # Inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/master";
    };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
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
          ./home-manager
        ];
      } 
    ]; 

  in {
    nixosConfigurations = {
      Namaku1801 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs;
        };
        modules = genericModules ++ [
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
      };
    };
  };
}
