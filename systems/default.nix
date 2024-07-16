variables @ { genImports, pkgs, lib, config, customImportWithDefault, genImportsWithDefault, customImport, ... }:
customImportWithDefault {
  initial = {
    imports = genImportsWithDefault ./others;
  };

  folder = ./.;
  inherit variables;
}
