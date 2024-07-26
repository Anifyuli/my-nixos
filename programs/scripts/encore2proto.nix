{ pkgs, ... }: sh: let
  encore-src = pkgs.fetchFromGitHub {
    name = "encore-source";
    owner = "encoredev";
    repo = "encore";
    rev = "v1.39.0";
    hash = "sha256-71vzo52vV4VilBnLZxIWDKIY08rfTavMZ57qgi4pip8=";
  };
in sh [
  pkgs.buf
] ''
cd ${encore-src}/proto
text=""
[ $# -lt 1 ] && {
  while read -r anu; do
    text="''${text}
''${anu}";
  done;
} || text="$1"
[ -z "$text" ] && exit 1
echo "$text" | buf convert --type encore.runtime.v1.RuntimeConfig --from -#format=json | base64
''
