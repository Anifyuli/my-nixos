{ pkgs, config, inputs, customImport, system, lib, ... }: let

  # create cert
  tls-cert = {  alt ? [], cname ? "localhost" }: let
    result = pkgs.runCommand "selfSignedCert" { buildInputs = [ pkgs.openssl ]; } ''
      mkdir -p $out
      openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -days 365 -nodes \
        -keyout $out/cert.key -out $out/cert.crt \
        -subj "/CN=${cname}" -addext "subjectAltName=DNS:localhost,${builtins.concatStringsSep "," (["IP:127.0.0.1"] ++ alt)}"
    '';
    in result;

  certs = {
    anu-cert = tls-cert { cname = "download.mikrotik.com"; alt = [ "DNS:download.mikrotik.com" ]; };
  };

  nixpkgs-overlay = self: super: let
    inherit (builtins) foldl' getAttr;
    overlayNixpkgs = arr: obj: foldl' (acc: curr: let
      name = "_${curr}";
      importName = getAttr "nixpkgs-${curr}" inputs;
    in {
      "${name}" = import importName {
        inherit system;
        config.allowUnfree = true;
      };
    } // acc) obj arr;
  in overlayNixpkgs [ "23_11" "24_05" ] {
    fmpkgs = import inputs.fmpkgs {
      inherit system pkgs lib;
    };
    nur = import inputs.nur {
      nurpkgs = self;
    };
    extra = inputs.nixpkgs-extra.packages.${system};
  };

  custom-overlay = final: prev: {
    inherit certs;
    custom = {
      git = prev.git.override { withLibsecret = true; };
      obs-studio = final.wrapOBS {
        plugins = with final.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      };
    };
    json2nix = prev.writeScriptBin "json2nix" ''
      ${pkgs.python3}/bin/python ${prev.fetchurl {
        url = "https://gist.githubusercontent.com/Scoder12/0538252ed4b82d65e59115075369d34d/raw/e86d1d64d1373a497118beb1259dab149cea951d/json2nix.py";
        hash = "sha256-ROUIrOrY9Mp1F3m+bVaT+m8ASh2Bgz8VrPyyrQf9UNQ=";
      }} $@
    '';
  };

  function-overlay = self: super: (import ../fmchad.nix {
      inherit lib pkgs;
    }) // {
    printPath = x: let
      user = config.users.users.${x};
      home-manager = config.home-manager.users.${x};
      toString = arr: builtins.concatStringsSep ":" arr;
    in toString (
      # home-manager level
      home-manager.home.sessionPath ++ [ 
        "${user.home}/.local/share/flatpak/exports" # flatpak
        "/var/lib/flatpak/exports" # flatpak
        "${user.home}/.nix-profile/bin" # profile level
        "/etc/profiles/per-user/${user.name}/bin" # user level
        "/run/current-system/sw/bin" # system level
      ]);
  };

  package-overlay = self: super: customImport {
    folder = ./customs;
    variables = { inherit self super; };
    excludes = [
      "qutebrowser.nix"
    ];
  };  
in {
  nixpkgs.overlays = [
    inputs.agenix.overlays.default
    nixpkgs-overlay
    custom-overlay
    function-overlay
    package-overlay
    inputs.nixgl.overlay
  ];
}
