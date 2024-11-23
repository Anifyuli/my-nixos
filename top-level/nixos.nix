{ lib, inputs, ... }: let
  
in {
  flake.nixosModules = let
    self = {
      cachix = ../cachix.nix;
      programs = ../programs;
      modules = lib.optionals (builtins.pathExists ../modules) (lib.fmway.genImportsWithDefault ../modules);
      systems = ../systems;
    };
    selfNames = builtins.attrNames self;
  in builtins.foldl' (acc: name: acc // {
    "${name}".imports = lib.flatten [ self.${name} ];
  }) { 
    default.imports = lib.flatten (map (x: self.${x}) selfNames) ++
    (with inputs; [
      fmway-nix.nixosModules.default
      chaotic.nixosModules.default
      catppuccin.nixosModules.catppuccin
    ]);
  } selfNames;
}
# TODO
# - withHM : home-manager.nixosModules.home-manager, ../home-manager
# - withSecrets : agenix.nixosModules.default, ../secrets
