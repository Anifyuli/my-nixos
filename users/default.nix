# users.nix for users and user-installed packages.
{config, pkgs, ...}:

{

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anifyuli = {
    isNormalUser = true;
    shell = pkgs.bash;
    description = "Moh Anif Yuliansyah";
    extraGroups = [ "networkmanager" "wheel" "dialout" "gdm" "vboxusers" "kvm"];
    packages = with pkgs; [
      adw-gtk3
      anytype
      blender
      ciscoPacketTracer8
      endeavour
      firefox
      foliate
      gnome-extension-manager
      gnome.dconf-editor
      gnome.gnome-tweaks
      gnomeExtensions.appindicator
      gnomeExtensions.thinkpad-battery-threshold
      google-chrome
      hunspell
      libreoffice-fresh
      lollypop
      lunacy
      neovim
      obs-studio
      ptyxis
      vscode
      youtube-music
      zed-editor
      zotero-beta
    ];
  };
}
