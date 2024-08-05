{ config, lib, ... }: let
  inherit (lib) mkOption types;
in {
  options.data = mkOption {
    type = types.attrs;
    default = {};
  };
  config = {};
}
