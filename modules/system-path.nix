{ config, lib, pkgs, utils, modulesPath, ... }: let
  contextModule = "config/system-path.nix";
  defaultModule = import "${modulesPath}/${contextModule}" { inherit config lib pkgs modulesPath utils; };
in {
  disabledModules = [ contextModule ];
  options = defaultModule.options // {
    environment = defaultModule.options.environment // {
      excludePackages = lib.mkOption {
        type = with lib.types; listOf package;
        description = "exclude package in systemPackages";
        default = [];
      };
      systemPackages = let
        self = defaultModule.options.environment.systemPackages;
      in self // {
        type = self.type // {
          merge = loc: defs:
            utils.removePackagesByName (self.type.merge loc defs) config.environment.excludePackages;
        };
      };
    };
  };
  inherit (defaultModule) config;
}
