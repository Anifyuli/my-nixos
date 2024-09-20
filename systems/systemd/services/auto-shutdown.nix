{ pkgs, lib, config, ... }:
{
  script  = pkgs.writeScriptBin "auto-shutdown.sh" ''
    #!${lib.getExe pkgs.bash}

    export PATH=$PATH:${lib.makeBinPath (with pkgs;[
      systemd
      libnotify
      gnugrep
      gnused
    ])}

    SHUTDOWN_WITH=${toString (lib.attrByPath [ "data" "battery_limit" ] 5 config)}

    ${lib.fileContents ./auto-shutdown.sh}
  '';
  serviceConfig = {
    Type = "oneshot";
    User = "root";
  };
}
