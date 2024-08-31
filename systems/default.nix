{ pkgs
, lib
, config
, ...
}
@ variables
:
let
  inherit (lib.fmway)
    treeImport
    matchers
    genTreeImports
  ;
in treeImport {
  imports = genTreeImports ./extra;
}
{
  excludes = [
    "extra"
    # "boot/loader/grub"
    # "services/nginx"
    "services/phpfpm"
    "networking/wg-quick"
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
