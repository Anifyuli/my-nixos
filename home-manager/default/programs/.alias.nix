{ lib, ... }: let
  inherit (lib.fmway) matchers;
in [
{
  match = matchers.prefix "fastfetch";
  alias = settings: {
    inherit settings;
  };
}
]
