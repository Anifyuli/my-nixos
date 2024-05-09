# virtualbox.nix for setup VirtualBox
{config, pkgs,  ...}:

{

  # VirtualBox virtualization support
  users.extraGroups.vboxusers.members = [ "anifyuli" ];
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.host.package = pkgs.unstable.virtualbox;
  virtualisation.virtualbox.guest.x11 = true;
}
