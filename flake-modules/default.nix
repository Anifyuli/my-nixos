{ self, lib, inputs, inputs', ... }: let
  inherit (self) outputs;
in {
  debug = true;
  imports = [
    ./hm.nix
    ./nixos.nix
    ./nixosConfigurations.nix
  ];
  # perSystem = { pkgs, ... }:
  # {
  #   legacyPackages = pkgs;
  # };
  flake.lib = {
    # Will be imported to configuration and home-manager
    genSpecialArgs = { ... } @ var: let
      specialArgs = {
        inherit specialArgs lib;
        inputs = inputs // lib.optionalAttrs (var ? inputs && builtins.isAttrs var.inputs) var.inputs;
        outputs = outputs // lib.optionalAttrs (var ? outputs && builtins.isAttrs var.outputs) var.outputs;
        system =
          if var ? system && builtins.isString var.system then
            var.system
          else "x86_64-linux";
        root-path =
          if var ? root-path then
            var.root-path
          else "${specialArgs.outputs}";
        extraSpecialArgs = lib.fmway.excludeItems [ "lib" ] specialArgs;
      } // (lib.fmway.excludeItems [ "inputs" "outputs" "system" "root-path" ] var);
    in specialArgs;

    # TODO
    # mkNixos :: { inputs, outputs, system ? x86_64-linux, specialArgs ? {}, users ? [], disableModules ? [], modules ? [], withHomeManager :: (bool | list of user) } -> lib.nixosSystem
    mkNixos =
      { inputs
      , system ? "x86_64-linux"
      , specialArgs ? {}
      , users ? [] # (list of str or attrsOf (attrs | string<user> -> attrs | { config, lib, pkgs, user } -> attrs))
      , disableModules ? [] # TODO
      , modules ? []
      , withHM ? true # (bool | list selected user)
      , ... } @ args: let
      generatedSpecialArgs = self.lib.genSpecialArgs {
        inherit system inputs;
        inherit (self) outputs;
      } // specialArgs;
      generatedUsers = vars: let
        result =
          if builtins.isList users && builtins.all (x: builtins.isString x) users then
            self.lib.genUsers users (user: { home = "/home/${user}"; })
          else if builtins.isAttrs users then
            builtins.listToAttrs (map (name: let
              options = users.${name};
            in {
              inherit name;
              value =
                if builtins.isAttrs options then
                  (self.lib.genUser name options).${name}
                else if builtins.isFunction options then
                  let
                    vars =
                      if builtins.functionArgs options == {} then
                        name
                      else let
                        ctx = vars // { user = name; };
                        argsOpt = builtins.filter (x: ! options.${x}) (builtins.attrNames options);
                      in builtins.listToAttrs (map (name: {
                        inherit name;
                        value = if ctx ? name then ctx.name else throw "Unknown argument ${name} in users with name ${name}";
                      }) argsOpt);
                  in 
                    (self.lib.genUser name (options vars)).${name}
                else
                  throw "Unknown type ${builtins.typeOf options} for users with name ${name}"
              ;
            }) (builtins.attrNames users))
          else throw "Unknown type ${builtins.typeOf users} for users, must be (listOf str | str -> attrs | { config, lib, pkgs, user } -> attrs)";
      in result;
    in lib.nixosSystem {
      inherit system;
      inherit (generatedSpecialArgs) specialArgs;
      modules = modules
        ++ [ { data = { inherit disableModules; }; } ]
        ++ [
          ({ pkgs, lib, config, ... } @ vars: { users.users = generatedUsers vars; })
        ]
        ++ lib.optionals ((builtins.isBool withHM && withHM) || builtins.isList withHM)
        (let
          allUser =
            if builtins.isAttrs users then
              builtins.attrNames users
            else users;
          ctxUsers =
            if builtins.isBool withHM then
              allUser
            else withHM;
          backupFileExtension =
            "hm-backup~.${toString inputs.self.lastModified}";
        in lib.throwIf (builtins.all (x: ! builtins.any (y: x == y) allUser) ctxUsers) "some users in withHM are not found in users" [
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              verbose = true;
              sharedModules = lib.mkIf (builtins.isBool withHM) (with self.homeManagerModules; [
                modules
                another
              ]);
              users = builtins.listToAttrs (map (name: {
                inherit name;
                value.imports =
                  if builtins.isList withHM then
                    [ self.homeManagerModules.default ]
                  else [];
              }) ctxUsers);
              inherit backupFileExtension;
              inherit (generatedSpecialArgs) extraSpecialArgs;
            };
          }
          inputs.home-manager.nixosModules.home-manager
        ])
      ;
    };

    genUser = name: {
      description ? name,
      isNormalUser ? true,
      home ? "/home/${name}",
      extraGroups ? [
        "networkmanager" 
        "docker" 
        "wheel"
        "video"
        "gdm"
        "dialout"
        "kvm"
        "adbusers"
        "vboxusers"
        "fwupd-refresh"
      ],
      ... } @ args: {
        ${name} = args // {
          inherit description isNormalUser home extraGroups;
        };
    };

    genUsers = users: options: # users :: lists, options :: ( attrs | str -> attrs )
      if ! (builtins.isList users && (builtins.length users == 0 && true || builtins.all (x: builtins.isString x) users)) then
        abort "first params of genMultipleUser must be a list of string"
      else if ! (builtins.isAttrs options ||
        (builtins.isFunction options && builtins.isAttrs (options "test"))) then
        abort "second params of genMultipleUser must be an attrs or function that return attrs"
      else
      builtins.listToAttrs (map (name: {
        inherit name;
        value =
          if builtins.isAttrs options then
            (self.lib.genUser name options).${name}
          else
            (self.lib.genUser name (options name)).${name};
      }) users)
    ;
  };
}