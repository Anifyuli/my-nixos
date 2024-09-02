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

  registry =
    builtins.listToAttrs (map (x: {
      name =
        if x == "self" then
          "nixos"
        else
          x;
      value.flake = inputs.${x};
    }) (builtins.attrNames inputs));

  gc = {
    automatic = true;
    dates = "Mon,Fri *-*-* 00:00:00";
    options = "--delete-older-than 5d";
  };
}
