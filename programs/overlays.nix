{ pkgs, inputs, system, lib, getDefaultNixs, getNixs, basename, genImports, ... }:let
  gnome-overlay = self: super: {
    gnome = super.gnome.overrideScope (gself: gsuper: {
      nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
        buildInputs = nsuper.buildInputs ++ (with pkgs.gst_all_1; [
          gst-plugins-good
          gst-plugins-bad
        ]);
      });
    });
  };
  nixpkgs-overlay = _final: _prev: {
    _23_11 = import inputs.nixpkgs-23_11 {
      inherit system;
      config.allowUnfree = true;
    };
    _24_05 = import inputs.nixpkgs-24_05 {
      inherit system;
      config.allowUnfree = true;
    };
    _master = import inputs.nixpkgs-master {
      inherit system;
      config.allowUnfree = true;
    };
    fmpkgs = import inputs.fmpkgs {
      inherit system pkgs lib;
    };
  };

  custom-overlay = _final: prev: {
    custom = {
      git = prev.git.override { withLibsecret = true; };
    };
  };

  custom-closure = _final: _prev: rec {
    inherit getDefaultNixs getNixs genImports basename;
    tree-path = var: let
      dir = if builtins.isAttrs var && builtins.hasAttr "dir" var then 
          var.dir 
        else var;
      prefix = if builtins.isAttrs var && builtins.hasAttr"prefix" var then
          var.prefix 
        else dir;
      toList = { attr, prefix, base ? ./. }: 
        builtins.map (x: { 
          path = base + ("/" + x); 
          prefix = if prefix == "" then x else prefix + ("/" + x);
          type = builtins.getAttr x attr;
        }) (builtins.attrNames attr);
      condition = val: 
        let
          type = val.type;
          path = val.path;
          prefix = val.prefix;
        in
        if type == "regular" then
          prefix
        else
          all { dir = path; prefix = prefix; };
      all = { dir, prefix }: builtins.map condition (toList {
        attr = builtins.readDir dir;
        prefix = prefix;
        base = dir;
      });
    in  lib.flatten (all { dir = dir; prefix = prefix; });

    readEnv = file: builtins.foldl' (acc: curr: {
      "${builtins.elemAt curr 0}" = "${builtins.elemAt curr 1}";
    } // acc) {} (
      builtins.map (x: builtins.elemAt (builtins.split "^([^= ]+)=(.*)$" x) 1) (builtins.filter (x: x != "") (lib.splitString "\n" (builtins.readFile file)))); # Just to parse .env file to mapAttrs
    getEnv = entity: readEnv (lib.path.append ../secrets "${entity}.env");
    genPaths = home: paths: builtins.foldl' (acc: curr: [ "${home}/${curr}/bin" ] ++ acc) [] (lib.reverseList paths);
  };

  package-overlay = final: prev: {
    # qutebrowser = prev.qutebrowser.override { enableWideVine = true; }; 
  };

in {
  nixpkgs.overlays = [
    gnome-overlay
    nixpkgs-overlay
    custom-closure
    custom-overlay
    package-overlay
    inputs.nixgl.overlay
  ];
}
