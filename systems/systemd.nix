{ pkgs, customImport, config, lib, ... } @ variables:
{
  # Handling for packages that have init systemd
  packages = with pkgs; [
    cloudflare-warp
  ]; 

  targets.multi-user.wants = [
    "warp-svc.service"
  ];

}
