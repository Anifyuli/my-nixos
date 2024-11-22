# @description simple suck for handling folder
if set -q argv[1] && [ -d "$argv[1]" ]
  cd $argv[1]
  command nvim $argv[2..-1]
  cd -
else
  command nvim $argv
end
