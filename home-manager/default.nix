{ lib
# , pkgs
, inputs
, extraSpecialArgs
, ...
}
: let
  inherit (lib.fmway)
    customDefaultImport
    genImportsWithDefault
    # genTreeImports
  ;
  # date = let
  #   out = pkgs.runCommand "hm-date" {} "date +%d%m%Y%H%M%S > $out";
  # in lib.fileContents out;

  # hash = builtins.hashString "sha256" inputs.self.narHash;

  backupFileExtension =
    "hm-backup~"
  # + ".${hash}" # hash is very long
  + ".${toString inputs.self.lastModified}"
  # + ".${date}"
  # + ".${date}-${hash}"
  ;

in {

  home-manager = {
    sharedModules = with inputs; [
      catppuccin.homeManagerModules.catppuccin
      fmway-nix.homeManagerModules.default
      # nix-flatpak.homeManagerModules.nix-flatpak
    ] ++ lib.optionals (builtins.pathExists ./modules) (genImportsWithDefault ./modules);
    useGlobalPkgs = true;
    useUserPackages = true;
    verbose = true;
    users = customDefaultImport ./.;
    inherit backupFileExtension extraSpecialArgs;
  };
}
