{ pkgs, ... }: ''
command=$1
shift 1
nix shell nixpkgs#$command -c $command "$@"
''
