{ pkgs, customImport, ... }:
{
  # Setup Cloudflared tunnel
  users.users.cloudflared = {
    group = "cloudflared";
    isSystemUser = true;
  };

  users.groups.cloudflared = { };

  # systemd services
  systemd = {

    services = customImport {
      folder = ./.;
      variables = { inherit pkgs; };
    };

    # Handling for packages that have init systemd
    packages = with pkgs; [
      cloudflare-warp
    ]; 

    targets.multi-user.wants = [
      "warp-svc.service"
    ];

  };
}
