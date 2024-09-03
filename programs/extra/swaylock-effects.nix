{ self, super, ... }: let
  pkgs = self;
in super.swaylock-effects.overrideAttrs (old: {
  buildInputs = old.buildInputs ++ (with pkgs; [
    cmake
    wayland-scanner
  ]);

  nativeBuildInputs = old.nativeBuildInputs ++ (with pkgs;[
    wayland-scanner
    cmake
  ]);
})
