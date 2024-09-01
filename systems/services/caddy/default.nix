{ domains, lib, ... }: let
  inherit (builtins) attrNames map;
  inherit (lib) listToAttrs;
  inherit (lib.fmway)
    excludeItems
  ;
in {
  enable = true;
  virtualHosts = listToAttrs (map (x: let
    v = domains.${x};
    enable =
      if v ? enable && ! v.enable then
        false
      else true;
  in {
    name =
      if v ? type && v.type == "https" then
        "https://${x}"
      else if v ? type && v.type == "http" then
        "http://${x}"
      else x;
    value = lib.mkIf enable (excludeItems [ "type" "enable" ] v);
  }) (attrNames domains));
}
