{ config, inputs, ... }:
{
  sessionVariables = {
    # LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    # NIXOS_OZONE_WL = "1";
  };

  # links all (system app installed) to /run/current-system/sw
  pathsToLink = [
    "/share/fish"
  ];

  etc = let
    inherit (builtins) listToAttrs attrNames map;
    nix-inputs = listToAttrs (
      map (x: {
        name = "nix/inputs/${x}";
        value.source = inputs.${x}.outPath;
      }) (attrNames inputs)
    );
  in nix-inputs;
}
