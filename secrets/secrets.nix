let
  keys = {
    system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO58iqlTtlgkt9e8u7X6hbBusv6yf9LGJGk16/YhVDOw";
    fmway = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyjA20DdCiceuM3w328rtf8yv1FkawYhO/4zP7LWarc";
  };
  
  mySecret = arr: builtins.listToAttrs (map (name: {
    name = "${name}.age";
    value.publicKeys = [ keys.system ] ++
      (if name != "system" && keys ? ${name} then [ keys.${name} ] else []);
  }) arr);

in mySecret [ 
  "cloudflared"
  "wg0-private"
  "nix" # another nix.conf with encryption
  # "fmway"
] 
