{ pkgs, lib, ... }: # sh
''
#!${lib.getExe pkgs.bash}

export PATH=$PATH:${lib.makeBinPath (with pkgs;[
  sysctl
])}

${lib.fileContents ./warnet.sh}
''
