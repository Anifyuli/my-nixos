{ treeImport, matchers, pkgs, lib, config, genImportsWithDefault, ... } @ variables:
treeImport
{
  imports = genImportsWithDefault ./others;
}
{
  excludes = [
    "others"
    "boot/binfmt"
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

