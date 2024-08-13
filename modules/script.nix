{ lib
, config
, pkgs
, doImport
, basename
, getNixs
, ...
} @ variables: let
  cfg = config.programs.script;
  inherit (builtins) listToAttrs readFile pathExists isFunction isAttrs isString;
  inherit (lib) mkIf mkEnableOption mkBefore mkAfter mkOption types recursiveUpdate;
in {
  options.environment.script = mkOption {
    type = types.attrs;
    default = {};
  };
  options.programs.script = {
    enable = mkEnableOption "enable script";
    cwd = mkOption {
      type = types.path;
      description = "directory script";
      example = ''
        cwd = ./scripts;
      '';
    };
    variables = mkOption {
      type = types.attrs;
      default = variables;
    };
  };
  config.environment = mkIf cfg.enable (let
    files = getNixs cfg.cwd;
    result = map (file: let
      context = doImport (cfg.cwd + "/${file}") cfg.variables;
      name = basename file;
      value = 
        if isString context then 
          pkgs.writeScriptBin name context 
        else if isAttrs context then
          pkgs.writeShellApplication (recursiveUpdate { 
            inherit name;
            text = if pathExists (cfg.cwd + "/${name}.sh") then
                readFile (cfg.cwd + "/${name}.sh")
              else "echo ${name} executed";
          } context)
        else if isFunction context then let
          function = runtimeInputs: text:
            pkgs.writeShellApplication { 
              inherit name runtimeInputs text;
            };
        in context function
        else throw "${file} is not like scripts :)";
    in {
      inherit name value;
    }) files;
  in {
    systemPackages = mkAfter (map (x: x.value) result);
    script = mkBefore (listToAttrs result);
  });
}
