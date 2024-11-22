{ inputs, lib, ... }:
{
  flake.homeManagerModules = let
    hmDir = ../home-manager;
    self = {
      modules = lib.optionals (builtins.pathExists (hmDir + "/modules")) (lib.fmway.genImportsWithDefault (hmDir + "/modules"));
      another.imports = with inputs; [
        catppuccin.homeManagerModules.catppuccin
        fmway-nix.homeManagerModules.default
      ];
    };
    selfNames = builtins.attrNames self;
  in builtins.foldl' (acc: name: acc // {
    "${name}".imports = lib.flatten [ self.${name} ];
  }) { 
    default.imports = lib.flatten (map (x: self.${x}) selfNames) ++
    [
      (hmDir + "/default")
    ];
  } selfNames;
}
