{ self, root-path, lib, super, config }: let
  inherit (lib)
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
    ++ lib.optionals (config ? home-manager && config.home-manager.users ? ${user}) config.home-manager.users.${user}.home.packages # home-manager packages
    );
  # parse env in folder ./secrets
  getEnv = entity: let
    path = root-path + "/secrets/${entity}.env";
    exists = builtins.pathExists path;
  in if exists then
    readEnv path
  else lib.warn "tidak dapat mencari env dengan nama ${entity}" {};
  
  # generate path to array
  genPaths = home: paths: 
    builtins.foldl' (acc: curr: [ "${home}/${curr}/bin" ] ++ acc) [] (reverseList paths);
}
