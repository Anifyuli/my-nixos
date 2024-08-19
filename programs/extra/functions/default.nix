{ self, super, config }:
rec {
  printPath = x: let
    user = config.users.users.${x};
    home-manager = config.home-manager.users.${x};
    toString = arr: builtins.concatStringsSep ":" arr;
  in toString (
    # home-manager level
    home-manager.home.sessionPath ++ [ 
      "${user.home}/.local/share/flatpak/exports" # flatpak
      "/var/lib/flatpak/exports" # flatpak
      "${user.home}/.nix-profile/bin" # profile level
      "/etc/profiles/per-user/${user.name}/bin" # user level
      "/run/current-system/sw/bin" # system level
    ]);
}
