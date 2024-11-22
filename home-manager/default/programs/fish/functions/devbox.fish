# @description the problem is process-compose, just can't parse from fish shell, i don't know
if set -q argv[1]
  and [ "$argv[1]" = "services" ]
  echo devbox "'"{$argv}"'" | bash
else
  command devbox $argv
end
