{ inputs, lib, ... }:
{
  flake.homeManagerModules = let
    hmDir = ../home-manager;
    self = {
      modules = lib.optionals (builtins.pathExists (hmDir + "/modules")) (lib.fmway.genImportsWithDefault (hmDir + "/modules"));
    };
    selfNames = builtins.attrNames self;
  in builtins.foldl' (acc: name: acc // {
    "${name}".imports = lib.flatten [ self.${name} ];
  }) { 
    default.imports = lib.flatten (map (x: self.${x}) selfNames) ++
    (with inputs; [
      (hmDir + "/default")
      catppuccin.homeManagerModules.catppuccin
      fmway-nix.homeManagerModules.default
    ]);
  } selfNames;
}
