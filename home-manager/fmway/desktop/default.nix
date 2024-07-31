{ customDefaultImport, config, treeImport, pkgs, lib, ... } @ variables:
{
  # import all in folder ./wayland to wayland.windowManager
  wayland.windowManager = treeImport {
    folder = ./wayland;
    inherit variables;
  };

  # import all in folder ./x to xsession.windowManager
  xsession.windowManager = treeImport {
    folder = ./x;
    depth = 0;
    inherit variables;
  };
}
