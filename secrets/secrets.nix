let
  keys = {
    system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO58iqlTtlgkt9e8u7X6hbBusv6yf9LGJGk16/YhVDOw";
    fmway = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyjA20DdCiceuM3w328rtf8yv1FkawYhO/4zP7LWarc";
  };

  inherit (builtins)
    foldl'
    hasAttr
    ;
  
  mySecret = arr: foldl' (acc: name: let
    file = "${name}.age";
    publicKeys = 
      if name != "system" && hasAttr name keys then
        [ keys.system keys.${name} ]
      else
        [ keys.system ];
  in {
    "${file}".publicKeys = publicKeys;
  } // acc) {} arr;

in mySecret [ 
  "cloudflared"
  # "fmway"
] 
