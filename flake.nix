{
  description = "My NixOS configuration";

  # Inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-24_05.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-23_11.url = "github:NixOS/nixpkgs/nixos-23.11";
    master.url = "github:NixOS/nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    # TODO implement impermanence
    # impermanence.url = "github:nix-community/impermanence";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.darwin.follows = "";
    };
    fmway-nix = {
      url = "github:fmway/fmway.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fmpkgs.url = "github:fmway/fmpkgs/master";
    nixpkgs-extra = {
      url = "github:luisnquin/nixpkgs-extra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # TODO
    # nix-colors.url = "github:misterio77/nix-colors";
    home-manager.url = "github:nix-community/home-manager/master";
    nixgl.url = "github:nix-community/NixGL";
    nur.url = "github:nix-community/nur";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  outputs = { self, ... } @ inputs:
  let
    inherit (self) outputs;
    inherit (self.nixosConfigurations.Namaku1801) pkgs;
    inherit (inputs.nixpkgs) lib;
    system = "x86_64-linux";

    inherit (inputs.fmway-nix) fmway;

    # Will be imported to configuration and home-manager
    genSpecialArgs = { ... } @ var: let
      specialArgs = {
        inherit specialArgs;
        inputs = lib.recursiveUpdate inputs (if var ? inputs && builtins.isAttrs var.inputs then var.inputs else {});
        outputs = lib.recursiveUpdate outputs (if var ? outputs && builtins.isAttrs var.outputs then var.outputs else {});
        system = if var ? system && builtins.isString var.system then var.system else system;
        inherit (inputs.fmway-nix) lib;
        root-path = if var ? root-path then var.root-path else ./.;
        extraSpecialArgs = fmway.excludeItems [ "lib" ] specialArgs;
      } // (fmway.excludeItems [ "inputs" "outputs" "system" "root-path" ] var);
    in specialArgs;

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

    genUsers = users: options: # users :: lists, options :: ( attrs | function -> attrs )
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
            (genUser name options).${name}
          else
            (genUser name (options name)).${name};
      }) users)
    ;

    nixosModules = let
      self = {
        cachix = ./cachix.nix;
        programs = ./programs;
        modules = lib.optionals (builtins.pathExists ./modules) (fmway.genImportsWithDefault ./modules);
        systems = ./systems;
        secrets = ./secrets;
        home-manager = ./home-manager;
      };
      selfNames = builtins.attrNames self;
    in builtins.foldl' (acc: name: acc // {
      "${name}".imports = lib.flatten [ self.${name} ];
    }) { 
      default.imports = lib.flatten (map (x: self.${x}) selfNames) ++
      (with inputs; [
        fmway-nix.nixosModules.default
        disko.nixosModules.default
        chaotic.nixosModules.default
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        # nix-flatpak.nixosModules.nix-flatpak
        # fingerprint-sensor.nixosModules.open-fprintd
        # fingerprint-sensor.nixosModules.python-validity
        agenix.nixosModules.default
        # inputs.nixos-shell.nixosModules.nixos-shell
      ]);
    } selfNames;

  in {
    inherit nixosModules fmway genSpecialArgs genUsers genUser;
    templates.default = {
      path = ./.;
      description = "My Nixos Configuration";
    };
    nixosConfigurations = {
      Namaku1801 = lib.makeOverridable lib.nixosSystem {
        inherit system;
        specialArgs = genSpecialArgs {
          inherit inputs outputs system;
        };
        modules = with inputs; [
          ./configuration.nix
          ./hardware-configuration.nix
          ./disk.nix
          ({ pkgs, ... }: {
            users.users = genUsers [ "fmway" ] (user: {
              home = "/home/${user}";
              shell = pkgs.fish;
            });
          })
          nixos-hardware.nixosModules.lenovo-thinkpad-t480
          nixosModules.default
        ];
      };
    };
    # inherit (self.nixosConfigurations.Namaku1801) config lib;
    packages.${system} = pkgs;
  };
}
