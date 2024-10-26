# users.nix for users and user-installed packages.
{pkgs, ...}:

{
  # Define a user account. Don't forget to set a password with ‘passwd’
  users.users.anifyuli = {
    isNormalUser = true;
    shell = pkgs.bash;
    description = "Moh Anif Yuliansyah";
    extraGroups = [ "networkmanager" "wheel" "dialout" "gdm" "vboxusers" "kvm" "docker" "fwupd-refresh" "podman" ];
    packages = with pkgs; [
      adw-gtk3
      anydesk
      anytype
      blender
      ciscoPacketTracer8
      dbeaver-bin
      dconf-editor
      endeavour
      firefox
      foliate
      genymotion
      gnome-extension-manager
      gnome-tweaks
      gnomeExtensions.appindicator
      gnomeExtensions.thinkpad-battery-threshold 
      gnomeExtensions.x11-gestures
      google-chrome
      hunspell
      libreoffice-fresh
      lollypop
      lunacy
      mongodb-compass
      obs-studio
      postman
      python311Packages.orange3
      scrcpy
      smile
      vscode
      youtube-music
      zotero-beta
    ];
  };
 
  # Register our user to VirtualBox extra groups
  users.extraGroups.vboxusers.members = [ "anifyuli" ];
}
