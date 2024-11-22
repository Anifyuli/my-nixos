{ inputs, lib, self, ... }: let
  system = "x86_64-linux";
  # inherit (self) outputs;
in {
  flake.nixosConfigurations = {
    Namaku1801 = self.lib.mkNixos {
      inherit system inputs;
      modules = with inputs; [
        ../configuration.nix
        ../hardware-configuration.nix
        ../disk.nix
        ../secrets
        agenix.nixosModules.default
        disko.nixosModules.default
        nixos-hardware.nixosModules.lenovo-thinkpad-t480
        self.nixosModules.default
      ];
      users = {
        fmway = { user, pkgs, ... }:
        {
          home = "/home/${user}";
          shell = pkgs.fish;
        };
      };
      withHM = true;
    };
    # Namaku1801 = inputs.nixpkgs.lib.nixosSystem {
    #   inherit system;
    #   specialArgs = self.lib.genSpecialArgs {
    #     inherit inputs outputs system;
    #   };
    #   modules = with inputs; [
    #     ../configuration.nix
    #     ../hardware-configuration.nix
    #     ../disk.nix
    #     ../secrets
    #     ({ pkgs, ... }: {
    #       users.users = self.lib.genUsers [ "fmway" ] (user: {
    #         home = "/home/${user}";
    #         shell = pkgs.fish;
    #       });
    #     })
    #     agenix.nixosModules.default
    #     disko.nixosModules.default
    #     nixos-hardware.nixosModules.lenovo-thinkpad-t480
    #     self.nixosModules.default
    #   ];
    # };
  };
  flake.legacyPackages.${system} = self.nixosConfigurations.Namaku1801.pkgs;
}
