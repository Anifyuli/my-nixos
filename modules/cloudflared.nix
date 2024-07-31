{ config, lib, pkgs, ... }: let
  cfg = config.programs.cloudflared;
  inherit (lib) mkIf mkEnableOption getExe mkOption types;
in {
  options.programs.cloudflared = {
    enable = mkEnableOption "enable cloudflared";
    package = mkOption {
      type = types.package;
      default = pkgs.cloudflared;
    };
    secretFile = mkOption {
      type = types.oneOf [ types.path types.str ];
    };
  };
  config = mkIf cfg.enable {

    # create user
    users.users.cloudflared = {
      group = "cloudflared";
      isSystemUser = true;
    };

    users.groups.cloudflared = { };

    # create cloudflared.service
    systemd.services.cloudflared = {
      description = "Cloudflare Tunnel";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      serviceConfig = {
        EnvironmentFile = cfg.secretFile;
        ExecStart = "${getExe cfg.package} tunnel --no-autoupdate run --token \${TOKEN}";
        Restart = "always";
        User = "cloudflared";
        Group = "cloudflared";
      };
    };
  };
}
