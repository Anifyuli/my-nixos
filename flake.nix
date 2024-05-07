{
  description = "Mweheheheheheehehehehehe";

  # Inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    # nixvim = {
      # url = "github:nix-community/nixvim/nixos-23.11";
      # inputs.nixpkgs.follows = "nixpkgs";
    #   url = "github:fmway/nixvim-config";
    # };
    # kickstart-nvim = {
      # url = "github:nix-community/kickstart-nix.nvim";
    # };
    neovim-flake.url = "github:jordanisaacs/neovim-flake";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, nixpkgs-unstable, ... } @ inputs: let
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
      ({ config, nixpkgs, pkgs, ... }: {
        nixpkgs.overlays = [
          overlay-unstable
          #kickstart-nvim.overlays.default
          # neovim-flake.overlays.default
          #(final: prev: {
          #  neovim = nixvim.packages.${system}.default;
          #})
        ];
      })
      # Nixvim
      # nixvim.nixosModules.nixvim 
    ];
    # unstable overlay
    overlay-unstable = _final: _prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };

  in {
    # overlays = [ overlay-unstable ];
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
