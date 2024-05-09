{ pkgs, ... }: {
  enable = true;
  packageConfigurable = pkgs.vim;
  defaultEditor = true;
  settings = {
    expandtab = true;
    mouse = "a";
    number = true;
    shiftwidth = 2;
    tabstop = 2;
  };
  extraConfig = ''
    set softtabstop=2
    set smartindent
  '';
}
