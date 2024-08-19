{ inputs, super, ... }: let
  pkgs = super;
  inherit (pkgs.stdenv) system;
in inputs.matui.packages.${system}.matui
