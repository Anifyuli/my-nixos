{
  description = "Mweheheheheheehehehehehe";

  # Inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-24_05.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-23_11.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/master";
    fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
    };
    nixgl.url = "github:nix-community/NixGL";
  };

  outputs = { self, nixpkgs, nixos-hardware, fingerprint-sensor, home-manager, nixpkgs-23_11, nixpkgs-24_05, nixpkgs-master, ... } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    getDefaultNixs = folder: lib.mapAttrsToList (name: value: "${name}") (lib.filterAttrs (key: value: value == "directory" && lib.pathExists (lib.path.append folder "${key}/default.nix")) (builtins.readDir folder));
    getNixs = folder: lib.mapAttrsToList (name: value: "${name}") (lib.filterAttrs (key: value: value == "regular" && lib.hasSuffix ".nix" key && key != "default.nix") (builtins.readDir folder));
    genImports = folder: lib.mapAttrsToList (name: _: lib.path.append folder name) (lib.filterAttrs (key: value: value == "regular" && lib.hasSuffix ".nix" key && key != "default.nix") (builtins.readDir folder));
    basename = k: builtins.head (builtins.match "^(.*)\\.(.*)$" (builtins.baseNameOf k));
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

  in rec {
    nixosConfigurations = {
      Namaku1801 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs system genImports getNixs getDefaultNixs basename;
        };
        modules = genericModules ++ [
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
      };
    };
    packages.${system} = nixosConfigurations.Namaku1801.pkgs;
  };
}
