{ lib, config, pkgs, ... }: let
  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    types
    ;

  cfg = config.programs.cargo;

  iniFormat = pkgs.formats.ini { };

in {
  options = {
    programs.cargo = {
      enable = mkEnableOption "enable cargo features";
      package = mkOption {
        type = types.package;
        default = pkgs.cargo;
      };
      config = mkOption {
        type = iniFormat.type;
        default = {};
      };
    };
  };
  config = mkIf cfg.enable {
    home.file.".cargo/config" = mkIf (cfg.config != { }) {
      source = iniFormat.generate "config" cfg.config;
    };
  };
}
