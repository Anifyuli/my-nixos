{ config, lib, pkgs, modulesPath, ... }: let
  contextModule = "home-environment.nix";
  defaultModule = import "${modulesPath}/${contextModule}" { inherit config lib pkgs modulesPath; };
  removePackagesByName = packages: packagesToRemove:
    let
      namesToRemove = map lib.getName packagesToRemove;
    in with lib;
      filter (x: !(elem (getName x) namesToRemove)) packages;
in {
  disabledModules = [ contextModule ];
  options = defaultModule.options // {
    home = defaultModule.options.home // {
      packages = let
        self = defaultModule.options.home.packages;
      in self // {
        type = self.type // {
          merge = loc: defs:
            removePackagesByName (self.type.merge loc defs) config.home.excludePackages;
        };
      };
      excludePackages = lib.mkOption {
        type = with lib.types; listOf package;
        description = "exclude package in home.packages";
        default = [];
      };
    };
  };
  inherit (defaultModule) config;
}
