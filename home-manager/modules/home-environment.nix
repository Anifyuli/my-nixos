{ config, lib, pkgs, utils, modulesPath, ... }: let
  contextModule = "home-environment.nix";
  defaultModule = import "${modulesPath}/${contextModule}" { inherit config lib pkgs modulesPath utils; };
in {
  disabledModules = [ contextModule ];
  options = defaultModule.options // {
    home = defaultModule.options.home // {
      packages = let
        self = defaultModule.options.home.packages;
      in self // {
        type = self.type // {
          merge = loc: defs:
            utils.removePackagesByName (self.type.merge loc defs) config.home.excludePackages;
        };
      };
      excludePackages = lib.mkOption {
        type = with lib.types; listOf package;
        description = "exclude package in systemPackages";
        default = [];
      };
    };
  };
  inherit (defaultModule) config;
}
