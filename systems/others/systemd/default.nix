{ pkgs, customImport, config, lib, ... } @ variables:
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
      inherit variables;
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
