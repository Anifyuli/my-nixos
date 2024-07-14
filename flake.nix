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
    lib = nixpkgs.lib;
    getDefaultNixs = folder: let
      filtered = key: value: value == "directory" && lib.pathExists (lib.path.append folder "${key}/default.nix");
      dir = builtins.readDir folder;
    in lib.mapAttrsToList (name: value: "${name}") (lib.filterAttrs filtered dir);
    getNixs = folder: let
      filtered = key: value: value == "regular" && lib.hasSuffix ".nix" key && key != "default.nix";
      dir = builtins.readDir folder;
    in lib.mapAttrsToList (name: value: "${name}") (lib.filterAttrs filtered dir);
    genImports = folder: builtins.foldl' (acc: curr: [
      (lib.path.append folder curr)
    ] ++ acc) [] (getNixs folder);
    genDefaultImports = folder: builtins.foldl' (acc: curr: [
      (lib.path.append folder curr)
    ] ++ acc) [] (getDefaultNixs folder);
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
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit nix-colors getNixs genImports genDefaultImports basename getDefaultNixs; };
        };
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
          inherit inputs outputs system genImports getNixs getDefaultNixs genDefaultImports basename;
        };
        modules = genericModules ++ [
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
      };
    };
    packages.${system} = self.nixosConfigurations.Namaku1801.pkgs;
  };
}
