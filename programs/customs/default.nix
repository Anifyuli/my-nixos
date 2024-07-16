self: super: let
  inherit (import ../../fmchad.nix { inherit (super) lib; }) customImport;
in customImport {
  folder = ./.;
  variables = { inherit self super; };
  excludes = [
    "qutebrowser.nix"
  ];
}
