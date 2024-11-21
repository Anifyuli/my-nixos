{ config, lib, pkgs, utils, modulesPath, ... }: let
  contextModule = "home-environment.nix";
  defaultModule = import "${modulesPath}/${contextModule}" { inherit config lib pkgs modulesPath utils; };
in {
  disabledModules = [ contextModule ];
  options = defaultModule.options // {
    home = defaultModule.options.home // {
      excludePackages = lib.mkOption {
        type = with lib.types; listOf package;
        description = "exclude package in systemPackages";
        default = [];
      };
    };
  };
  config = defaultModule.config // {
    home = defaultModule.config.home // {
      path = defaultModule.config.home.path.overrideAttrs {
        paths = with config.home; utils.removePackagesByName packages excludePackages;
      };
    };
  };
}
