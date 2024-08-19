# @description remove string  'str' "str"
[ -z $argv ] && set -l argv && while read line
  set argv $argv $line
end
for string in $argv
  string replace -r '[\'"]([\s\S]+)[\'"]$' '$1' -- $string
end
