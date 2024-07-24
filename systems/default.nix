{ treeImport, genImports, pkgs, lib, config, customImportWithDefault, genImportsWithDefault, customImport, ... } @ variables:
treeImport {
  initial = {
    imports = genImportsWithDefault ./others;
  };
  excludes = [
    "others"
    "boot/binfmt"
    "boot/loader/grub"
    "services/nginx"
    "services/phpfpm"
  ];

  folder = ./.;
  inherit variables;
}
