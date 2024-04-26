# users.nix for users and user-installed packages.
{config, pkgs, ...}:

{

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anifyuli = {
    isNormalUser = true;
    shell = pkgs.bash;
    description = "Moh Anif Yuliansyah";
    extraGroups = [ "networkmanager" "wheel" "dialout" "gdm" "vboxusers" "kvm" "adbusers"];
    packages = with pkgs; [
      # Stable channel
      adw-gtk3
      alacritty
      alacritty-theme
      firefox
      gnome-extension-manager
      gnome.dconf-editor
      gnome.gnome-tweaks
      google-chrome
      hunspell
      libreoffice-fresh
      lollypop
      neovim
      zotero
      
      # Unstable channel
      unstable.android-studio
      unstable.anytype
      unstable.blender
      unstable.ciscoPacketTracer8
      unstable.discord
      unstable.foliate
      unstable.fzf-obc
      unstable.gnomeExtensions.thinkpad-battery-threshold
      unstable.lunacy
      unstable.telegram-desktop
      unstable.universal-android-debloater
      unstable.vscode
      unstable.youtube-music
    ];
  };
}
