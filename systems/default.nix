{ treeImport
, matchers
, pkgs
, lib
, config
, genTreeImports
, ... } @ variables:

treeImport {
  imports = genTreeImports ./extra;
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
