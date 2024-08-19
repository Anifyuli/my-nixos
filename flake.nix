{
  description = "Mweheheheheheehehehehehe";

  # Inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-24_05.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-23_11.url = "github:NixOS/nixpkgs/nixos-23.11";
    matui.url = "github:pkulak/matui";
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
    #   inputs.nixpkgs.follows = "nixpkgs-23_11";
    # };
    nixgl.url = "github:nix-community/NixGL";
    # nur.url = "github:nix-community/nur";
  };

  outputs = 
    { self
    , nixpkgs
    , nixos-hardware
    , fmway-nix
    # , fingerprint-sensor
    , agenix
    , home-manager
    , ... }
    @ inputs:
  # std.growOn {
  #   inputs = inputs // { outputs = self.outputs; };
  #   cellsFrom = ./cells;
  #   cellBlocks = with std.blockTypes; [
  #     (functions "functions")
  #   ];
  # }
  (let
    inherit (self) outputs;
    inherit (self.nixosConfigurations.Namaku1801) pkgs;
    inherit (nixpkgs) lib;
    system = "x86_64-linux";
    # fmchad = import ./fmchad.nix { inherit lib; };
    # fmchad = (std.harvest inputs.self [ "fmchad" "functions" ]).${system};
    fmchad = (import fmway-nix {
      inherit pkgs lib;
    }) // {
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
      inherit inputs outputs system specialArgs;
      root-path = ./.;
      extraSpecialArgs = specialArgs;
    };

  in {
    nixosConfigurations = {
      Namaku1801 = lib.makeOverridable lib.nixosSystem {
        inherit system specialArgs;
        modules = fmway-nix.nixosModules.modules ++ [
          ./configuration.nix
          ./cachix.nix
          ./hardware-configuration.nix
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
          # fingerprint-sensor.nixosModules.open-fprintd
          # fingerprint-sensor.nixosModules.python-validity
          agenix.nixosModules.default
          # inputs.nixos-shell.nixosModules.nixos-shell
        ] ++ (fmchad.genDefaultImports ./.);
      };
    };
    inherit fmchad;
    # inherit (self.nixosConfigurations.Namaku1801) config lib;
    packages.${system} = pkgs;
  });
}
