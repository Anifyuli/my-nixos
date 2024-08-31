{ pkgs, inputs, outputs, ... }:
{
  package = pkgs.nixFlakes;

  settings = {
    # Enable the Flakes feature and the accompanying new nix command-line tool
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "fmway"
    ];
    trusted-substituters = [
      # "https://cache.flox.dev"
    ];
    trusted-public-keys = [
      # "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
    ];
    # auto optimise the store
    auto-optimise-store = true;
  };

  registry = let
    inherit (builtins)
      foldl'
      hasAttr
    ;
    toRegistry = arr: foldl' (final: registry: {
      "${registry}".flake =
        if ! (hasAttr registry inputs) then
          throw "registry ${registry} not found"
        else inputs.${registry};
    } // final) {} arr;
  in {
    nixos.flake = inputs.self;
  } // (toRegistry [
    "nixpkgs"
    "nixpkgs-24_05"
    "nixpkgs-23_11"
    "fmpkgs"
    "nixpkgs-extra"
    "disko"
    "microvm"
  ]);

  gc = {
    automatic = true;
    dates = "Mon,Fri *-*-* 00:00:00";
    options = "--delete-older-than 5d";
  };
}
