# users.nix for users and user-installed packages.
{pkgs, ...}:

{
  # Define a user account. Don't forget to set a password with ‘passwd’
  users.users.anifyuli = {
    isNormalUser = true;
    shell = pkgs.bash;
    description = "Moh Anif Yuliansyah";
    extraGroups = [ "networkmanager" "wheel" "dialout" "sddm" "vboxusers" "kvm" "fwupd-refresh" "podman" ];
    packages = with pkgs; [
      anydesk
      anytype
      ciscoPacketTracer8
      dbeaver-bin
      endeavour
      foliate
      genymotion
      google-chrome
      hunspell
      libreoffice-fresh
      lunacy
      mongodb-compass
      obs-studio
      postman
      python311Packages.orange3
      scrcpy
      vscode
      youtube-music
      zotero-beta
    ];
  };
 
  # Register our user to VirtualBox extra groups
  users.extraGroups.vboxusers.members = [ "anifyuli" ];
}
