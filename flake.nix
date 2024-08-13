{
  description = "Mweheheheheheehehehehehe";

  # Inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-24_05.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-23_11.url = "github:NixOS/nixpkgs/nixos-23.11";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.darwin.follows = "";
    };
    std.url = "github:divnix/std";
    fmway-nix.url = "github:fmway/fmway.nix";
    fmway-nix.inputs.nixpkgs.follows = "nixpkgs";
    fmpkgs = {
      url = "github:fmway/fmpkgs/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # inputs.nixos-shell = {
    #   url = "github:Mic92/nixos-shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nixpkgs-extra = {
      url = "github:luisnquin/nixpkgs-extra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager.url = "github:nix-community/home-manager/master";
    fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
      inputs.nixpkgs.follows = "nixpkgs-23_11";
    };
    nixgl.url = "github:nix-community/NixGL";
    nur.url = "github:nix-community/nur";
  };

  outputs = { self, nixpkgs, nixos-hardware, fmway-nix, fingerprint-sensor, std, agenix, nix-colors, nixpkgs-extra, home-manager, ... } @ inputs:
  # std.growOn {
  #   inputs = inputs // { outputs = self.outputs; };
  #   cellsFrom = ./cells;
  #   cellBlocks = with std.blockTypes; [
  #     (functions "functions")
  #   ];
  # }
  (let
    inherit (self) outputs;
    inherit (nixpkgs) lib;
    system = "x86_64-linux";
    # fmchad = import ./fmchad.nix { inherit lib; };
    # fmchad = (std.harvest inputs.self [ "fmchad" "functions" ]).${system};
    fmchad = fmway-nix.fmway // {
      # parse env in folder ./secrets
      getEnv = entity: let
        path = ./secrets + "/${entity}.env";
        exists = builtins.pathExists path;
      in lib.throwIfNot exists "tidak dapat mencari env dengan nama ${entity}" fmchad.readEnv path;
      
      # generate path to array
      genPaths = home: paths: 
        builtins.foldl' (acc: curr: [ "${home}/${curr}/bin" ] ++ acc) [] (lib.reverseList paths);
    };

    # Will be imported to configuration and home-manager
    specialArgs = fmchad // {
      inherit inputs outputs system;
    };

    genericModules = [
      ./configuration.nix
      ./cachix.nix
      fingerprint-sensor.nixosModules.open-fprintd
      fingerprint-sensor.nixosModules.python-validity
      agenix.nixosModules.default
      # inputs.nixos-shell.nixosModules.nixos-shell
      # {
      #   # Fix for nixpkgs without flakes
      #   nix.registry.nixos.flake = inputs.self;
      #   environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
      #   nix.nixPath = [ "nixpkgs=${nixpkgs.outPath}" ];
      # }
      home-manager.nixosModules.home-manager
      {
        nix.registry.nixos.flake = inputs.self;
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          verbose = true;
          extraSpecialArgs = specialArgs;
          users = fmchad.customDefaultImport ./home-manager;
          backupFileExtension = "kontol~";
        };
      } 
  ]; 

  in {
    nixosConfigurations = {
      Namaku1801 = lib.makeOverridable lib.nixosSystem {
        inherit system specialArgs;
        modules = genericModules ++ (fmchad.genDefaultImports ./.) ++ (fmchad.genImportsWithDefault ./modules) ++ [
          ./hardware-configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
      };
    };
    inherit fmchad;
    inherit (self.nixosConfigurations.Namaku1801) config lib;
    packages.${system} = self.nixosConfigurations.Namaku1801.pkgs;
  });
}
