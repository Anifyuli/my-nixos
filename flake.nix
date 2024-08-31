{
  description = "My NixOS configuration";

  # Inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-24_05.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-23_11.url = "github:NixOS/nixpkgs/nixos-23.11";
    matui.url = "github:pkulak/matui";
    microvm.url = "github:astro/microvm.nix";
    catppuccin.url = "github:catppuccin/nix";
    # TODO implement impermanence
    # impermanence.url = "github:nix-community/impermanence";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.darwin.follows = "";
    };
    # std.url = "github:divnix/std";
    fmway-nix = {
      url = "github:fmway/fmway.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fmpkgs.url = "github:fmway/fmpkgs/master";
    # inputs.nixos-shell = {
    #   url = "github:Mic92/nixos-shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nixpkgs-extra = {
      url = "github:luisnquin/nixpkgs-extra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # nix-colors.url = "github:misterio77/nix-colors";
    home-manager.url = "github:nix-community/home-manager/master";
    # fingerprint-sensor = {
    #   url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nixgl.url = "github:nix-community/NixGL";
    nur.url = "github:nix-community/nur";
  };

  outputs = 
    { self
    , nixpkgs
    , nixos-hardware
    , disko
    , fmway-nix
    , catppuccin
    # , fingerprint-sensor
    , agenix
    , home-manager
    , ...
    }
    @ inputs
    :
  let
    inherit (self) outputs;
    inherit (self.nixosConfigurations.Namaku1801) pkgs;
    inherit (nixpkgs) lib;
    system = "x86_64-linux";
    # fmchad = import ./fmchad.nix { inherit lib; };
    # fmchad = (std.harvest inputs.self [ "fmchad" "functions" ]).${system};
    inherit (fmway-nix) fmway;

    # Will be imported to configuration and home-manager
    specialArgs = {
      inherit inputs outputs system specialArgs;
      inherit (fmway-nix) lib;
      root-path = ./.;
      extraSpecialArgs = fmway.excludeItems [ "lib" ] specialArgs;
    };

    nixosModules = let
      self = {
        cachix = ./cachix.nix;
        programs = ./programs;
        modules = lib.optionals (builtins.pathExists ./modules) (fmway.genImportsWithDefault ./modules);
        systems = ./systems;
        users = ./users;
        secrets = ./secrets;
        home-manager = ./home-manager;
      };
      selfNames = builtins.attrNames self;
    in builtins.foldl' (acc: name: acc // {
      "${name}".imports = lib.flatten [ self.${name} ];
    }) rec { 
      default.imports = lib.flatten (map (x: self.${x}) selfNames);
      defaultModules = [
        default
        fmway-nix.nixosModules.default
        disko.nixosModules.default
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        # fingerprint-sensor.nixosModules.open-fprintd
        # fingerprint-sensor.nixosModules.python-validity
        agenix.nixosModules.default
        # inputs.nixos-shell.nixosModules.nixos-shell
      ];
    } selfNames;

  in {
    inherit nixosModules fmway;
    nixosConfigurations = {
      Namaku1801 = lib.makeOverridable lib.nixosSystem {
        inherit system specialArgs;
        modules = nixosModules.defaultModules ++ [
          ./configuration.nix
          ./hardware-configuration.nix
          ./disk.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
      };
    };
    # inherit (self.nixosConfigurations.Namaku1801) config lib;
    packages.${system} = pkgs;
  };
}
