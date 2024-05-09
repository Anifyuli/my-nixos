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
      # Stable channel
      adw-gtk3
      firefox
      gnome-extension-manager
      gnome.dconf-editor
      gnome.gnome-tweaks
      gnomeExtensions.appindicator
      google-chrome
      hunspell
      libreoffice-fresh
      lollypop
      neovim
      zotero

      # OBS Studio wrapping in unstable channel
      (unstable.wrapOBS {
        plugins = with unstable.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
       })
      
      # Unstable channel
      unstable.anytype
      unstable.blender
      unstable.ciscoPacketTracer8
      unstable.foliate
      unstable.fzf-obc
      unstable.gnomeExtensions.thinkpad-battery-threshold
      unstable.vscode
      unstable.youtube-music
    ];
  };
}
