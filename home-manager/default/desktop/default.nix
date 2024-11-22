{ pkgs
, lib
, ... }
@ variables
:
let
  inherit (lib.fmway)
    matchers
    treeImport
  ;
in {
  # import all in folder ./wayland to wayland.windowManager
  wayland.windowManager = treeImport {
    folder = ./wayland;
    includes = with matchers; [
      (extension "conf")
      (filename "config")
    ];
    inherit variables;
  };

  # import all in folder ./x to xsession.windowManager
  xsession.windowManager = treeImport {
    folder = ./x;
    inherit variables;
  };
}
