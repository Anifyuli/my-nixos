{ treeImport
, matchers
, pkgs
, lib
, config
, genTreeImports
, ... } @ variables:

treeImport {
  imports = genTreeImports ./extra;

  data = {
    list-users = let
      inherit (config.home-manager) users;
      inherit (builtins) attrNames;
    in map (x: users.${x}.home.username) (attrNames users); # i use home-manager.users instead of users.users, because i don't want ribet pake filter segala
  };
}
{
  excludes = [
    "boot/binfmt"
    "extra"
    # "boot/loader/grub"
    # "services/nginx"
    "services/phpfpm"
    # "services/stubby"
  ];

  includes = with matchers; [
    (extension "conf")
    (extension "txt")
  ];

  # auto-enable = [
  #   ["services"] # services.*.enable = true;
  # ];

  folder = ./.;
  inherit variables;
}

