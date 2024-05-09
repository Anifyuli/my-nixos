{ pkgs, ... }:
{
  isNormalUser = true;
  description = "fmway";
  extraGroups = ["networkmanager" "wheel" "video" "gdm" "dialout"];
  packages = with pkgs; [
    gnome-extension-manager
    gnome.dconf-editor
    gnome.gnome-tweaks
    gnomeExtensions.pop-shell
    winbox
    # Google chrome with wayland support
    (google-chrome.override {
      commandLineArgs = [
        "--enable-features=VaapiVideoDecodeLinuxGL"
        "--use-gl=angle"
        "--use-angle=gl"
        "--ozone-platform=wayland"
      ];
    })

    unstable.zoom-us
    discord
    telegram-desktop
    libreoffice-fresh
    zotero
    unstable.anytype
    kdenlive
    mpv

    unstable.rustup
    unstable.zls
    unstable.zig
    unstable.deno
    unstable.bun

    (unstable.wrapOBS {
      plugins = with obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
     })
  ];
  shell = pkgs.fish;
}
































