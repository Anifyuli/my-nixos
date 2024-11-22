{ lib, ... }: let
  inherit (lib.fmway)
    matchers
    parseFish
  ;
in [
{
  match = matchers.extension "fish";
  alias = value: parseFish value;
}
]
