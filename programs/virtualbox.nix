# virtualbox.nix for setup VirtualBox
{config, pkgs,  ...}:

{

  # VirtualBox virtualization support
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "anifyuli" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
