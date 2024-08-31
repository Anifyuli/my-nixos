{ self, root-path, lib, super, config }: let
  inherit (lib)
    throwIfNot
    reverseList
  ;
  inherit (lib.fmway)
    readEnv
  ;
in {
  # printPath = x: let
  #   user = config.users.users.${x};
  #   home-manager = config.home-manager.users.${x};
  #   toString = arr: builtins.concatStringsSep ":" arr;
  # in toString (
  #   # home-manager level
  #   home-manager.home.sessionPath ++ [ 
  #     "${user.home}/.local/share/flatpak/exports" # flatpak
  #     "/var/lib/flatpak/exports" # flatpak
  #     "${user.home}/.nix-profile/bin" # profile level
  #     "/etc/profiles/per-user/${user.name}/bin" # user level
  #     "/run/current-system/sw/bin" # system level
  #   ]);
  printPath = user:
    lib.makeBinPath (
       config.environment.systemPackages # system packages
    ++ config.users.users.${user}.packages # user packages
    ++ config.home-manager.users.${user}.home.packages # home-manager packages
    );
  # parse env in folder ./secrets
  getEnv = entity: let
    path = root-path + "/secrets/${entity}.env";
    exists = builtins.pathExists path;
  in throwIfNot exists "tidak dapat mencari env dengan nama ${entity}" readEnv path;
  
  # generate path to array
  genPaths = home: paths: 
    builtins.foldl' (acc: curr: [ "${home}/${curr}/bin" ] ++ acc) [] (reverseList paths);
}
