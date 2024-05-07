# Cloudflared tunnel
{ pkgs, ... }: {
  users.users.cloudflared = {
    group = "cloudflared";
    isSystemUser = true;
  };

  users.groups.cloudflared = { };

  # Systemd for cloudflared tunnel
  systemd.services.cloudflared = {
    description = "Cloudflare Tunnel";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token eyJhIjoiNjcwNTQ1NDRkOWRkMTUxYTFkMTE3MWE1MGZhMWQxNWYiLCJ0IjoiNWQxM2NkYTAtZjgwNS00NjhlLTliOWUtMjk0ZmY4OTEwMzNmIiwicyI6IlpqaGxOVEZqTkdZdE4yVTFaQzAwTmpRMkxXSTJaRGN0TUdKalltWTNNVGhsTXpGaCJ9";
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };
}
