{ pkgs, ... }:
{
  description = "Cloudflare Tunnel";
  wantedBy = [ "multi-user.target" ];
  after = [ "network-online.target" ];
  wants = [ "network-online.target" ];
  serviceConfig = {
    EnvironmentFile = "/etc/nixos/secrets/cloudflared.env";
    ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token \${TOKEN}";
    Restart = "always";
    User = "cloudflared";
    Group = "cloudflared";
  };
}
