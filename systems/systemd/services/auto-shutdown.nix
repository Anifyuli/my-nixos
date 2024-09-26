{ pkgs, lib, config, ... }:
{
  script  = ''
    #!${lib.getExe pkgs.bash}

    export PATH=$PATH:${lib.makeBinPath (with pkgs;[
      systemd
      libnotify
      gnugrep
      su
      gnused
      gawk
      ps
      sysvtools
    ])}

    export SHUTDOWN_WITH=${toString (lib.attrByPath [ "data" "battery_limit" ] 5 config)}

    ${lib.fileContents ./auto-shutdown.sh}
  '';
  serviceConfig = {
    Type = "oneshot";
    User = "root";
  };
}
