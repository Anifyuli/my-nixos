{ getDefaultNixs, lib, ... }: {
  home-manager.users = let
    folder = ./.;
    list = getDefaultNixs folder;
  in builtins.foldl' (acc: curr: {
      "${curr}" = import (lib.path.append folder curr);
    } // acc) {} list;
}

