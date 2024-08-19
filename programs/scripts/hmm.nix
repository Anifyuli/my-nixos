{ pkgs, lib, ... }:
''
#!${lib.getExe pkgs.php}

${lib.fileContents ./hmm.php}
''
