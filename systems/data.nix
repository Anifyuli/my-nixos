{ config, ... }: let
  inherit (config.home-manager) users;
  inherit (builtins) attrNames;
in {
  list-users = map (x: users.${x}.home.username) (attrNames users); # i use home-manager.users instead of users.users, because i don't want ribet pake filter segala
}
