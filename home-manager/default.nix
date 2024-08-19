{ customDefaultImport
, extraSpecialArgs
, genTreeImports
# , lib
# , pkgs
, inputs
, ... }: let
  
  # date = let
  #   out = pkgs.runCommand "hm-date" {} "date +%d%m%Y%H%M%S > $out";
  # in lib.fileContents out;

  hash = builtins.hashString "sha256" inputs.self.narHash;

  backupFileExtension =
    "hm-backup~"
  + ".${hash}"
  # + ".${date}"
  # + ".${date}-${hash}"
  ;

in {

  home-manager = {
    sharedModules = inputs.fmway-nix.homeManager.modules;
    useGlobalPkgs = true;
    useUserPackages = true;
    verbose = true;
    users = customDefaultImport ./.;
    inherit backupFileExtension extraSpecialArgs;
  };
}
