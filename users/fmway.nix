{ pkgs, ... }:
{
  isNormalUser = true;
  description = "fmway";
  extraGroups = ["networkmanager" "wheel" "video" "gdm" "dialout"];
  packages = with pkgs; [
    gnome-extension-manager
    gnome.dconf-editor
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.thinkpad-battery-threshold
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
    (microsoft-edge.override {
      commandLineArgs = [
        "--enable-features=VaapiVideoDecodeLinuxGL"
        "--use-gl=angle"
        "--use-angle=gl"
        "--ozone-platform=wayland"
      ];
    })

    zoom-us
    discord
    telegram-desktop
    libreoffice-fresh
    zotero
    anytype
    kdenlive
    mpv

    rustup
    zls
    zig
    deno
    bun

    (wrapOBS {
      plugins = with obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
     })
  ];
  shell = pkgs.fish;
}
































