{ pkgs, inputs, system, lib, ... }:let
  gnome-overlay = self: super: {
    gnome = super.gnome.overrideScope (gself: gsuper: {
      nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
        buildInputs = nsuper.buildInputs ++ (with pkgs.gst_all_1; [
          gst-plugins-good
          gst-plugins-bad
        ]);
      });
    });
  };
  nixpkgs-overlay = _final: _prev: {
    _23_11 = import inputs.nixpkgs-23_11 {
      inherit system;
      config.allowUnfree = true;
    };
    _24_05 = import inputs.nixpkgs-24_05 {
      inherit system;
      config.allowUnfree = true;
    };
    _master = import inputs.nixpkgs-master {
      inherit system;
      config.allowUnfree = true;
    };
    fmpkgs = import inputs.fmpkgs {
      inherit system pkgs lib;
    };
  };

  custom-overlay = _final: prev: {
    custom = {
      git = prev.git.override { withLibsecret = true; };
    };
    json2nix = prev.writeScriptBin "json2nix" ''
      ${pkgs.python3}/bin/python ${prev.fetchurl {
        url = "https://gist.githubusercontent.com/Scoder12/0538252ed4b82d65e59115075369d34d/raw/e86d1d64d1373a497118beb1259dab149cea951d/json2nix.py";
        hash = "sha256-ROUIrOrY9Mp1F3m+bVaT+m8ASh2Bgz8VrPyyrQf9UNQ=";
      }} $@
    '';
  };

  package-overlay = self: super: {
    # qutebrowser = super.qutebrowser.override { enableWideVine = true; }; 
    mpv = super.mpv.override {
      scripts = with self.mpvScripts; [
        youtube-upnext
        webtorrent-mpv-hook
        visualizer
        sponsorblock
        # seekTo
        reload
        quality-menu
        quack
        mpv-playlistmanager
        # mpv-osc-modern
        mpv-cheatsheet
        mpris
        # modernx
        memo
        # manga-reader
        inhibit-gnome
        evafast
        uosc
      ];
    };
  };

in {
  nixpkgs.overlays = [
    gnome-overlay
    nixpkgs-overlay
    custom-overlay
    package-overlay
    inputs.nixgl.overlay
  ];
}
