# users.nix for users and user-installed packages.
{config, pkgs, ...}:

{

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anifyuli = {
    isNormalUser = true;
    shell = pkgs.bash;
    description = "Moh Anif Yuliansyah";
    extraGroups = [ "networkmanager" "wheel" "dialout" "gdm" "vboxusers" "kvm" "docker" ];
    packages = with pkgs; [
      adw-gtk3
      anydesk
      anytype
      blender
      ciscoPacketTracer8
      dconf-editor
      endeavour
      firefox
      foliate
      gnome-extension-manager
      gnome-tweaks
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
      thunderbird
      vscode-fhs
      youtube-music
      zotero-beta
    ];
  };
}
