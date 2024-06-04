{ pkgs, basename, getNixs, lib, ... }: let
  folder = ./.;
  list = getNixs folder;
in {
  users.users = lib.lists.foldl (acc: curr: {
    "${basename curr}" = import (lib.path.append folder curr) { inherit pkgs; };
    } // acc
  ) {} list;
}
