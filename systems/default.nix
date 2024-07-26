{ treeImport, genImports, pkgs, lib, config, customImportWithDefault, genImportsWithDefault, customImport, ... } @ variables:
treeImport {
  excludes = [
    "others"
    "boot/binfmt"
    "boot/loader/grub"
    "services/nginx"
    "services/phpfpm"
  ];

  folder = ./.;
  inherit variables;
} {
  imports = genImportsWithDefault ./others [];
}
