let
  keys = {
    system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO58iqlTtlgkt9e8u7X6hbBusv6yf9LGJGk16/YhVDOw";
    fmway = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKI9FTK016k949uoOby8U4BDa92wocG50DWXZD40OxGI";
  };
  
  mySecret = arr: builtins.listToAttrs (map (name: {
    name = "${name}.age";
    value.publicKeys = builtins.attrValues keys;
  }) arr);

in mySecret [ 
  "cloudflared"
  "wg0-private"
  "nix" # another nix.conf with encryption
  # "fmway"
] 
