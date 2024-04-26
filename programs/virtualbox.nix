# virtualbox.nix for setup VirtualBox
{config, pkgs,  ...}:

{

  # VirtualBox virtualization support
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "anifyuli" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;

}
