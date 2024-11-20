# Hidden secrets using agenix
{ lib, ... }:
let
  inherit (builtins) isList elemAt attrNames match toString listToAttrs length;

  getNameAge = value: let
    matched = match "^(.*)\\.age$" (toString value);
  in if isList matched then baseNameOf (elemAt matched 0) else matched;

  folder = ./.;

  resultAges = import ./secrets.nix;
  files = attrNames resultAges;

  # all /etc/nixos/secrets/<file>.age will be imported to age.secrets.<file>
  age.secrets = listToAttrs (map (file: rec {
    name = getNameAge file;
    value = let
      isOwnedUser = length resultAges.${file}.publicKeys > 1;
    in {
      file = folder + ("/" + file);
      path = "/etc/secrets/${name}";
      owner = lib.mkIf isOwnedUser name;
      mode =
        if isOwnedUser then
          "0660"  # rw-rw----
        else
          "0662"; # rw-rw-r--
      symlink = false;
    };
  }) files);
in {
  inherit age;
}
