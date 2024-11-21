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
    };
  };
  config = defaultModule.config // {
    system = defaultModule.config.system // {
      path = defaultModule.config.system.path.overrideAttrs {
        paths = with config.environment; utils.removePackagesByName systemPackages excludePackages;
      };
    };
  };
}
