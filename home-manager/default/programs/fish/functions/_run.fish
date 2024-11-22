if set -q DEBUG
  echo $argv
end
set -q NORUN || $argv
