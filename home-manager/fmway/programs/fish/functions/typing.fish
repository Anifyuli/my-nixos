set red2 (set_color brred)
set normal (set_color normal)
set -l cmd typing
set -l version_typing 1.0.0
set -l helps_typing \
  "\t-c\t\t\tCapitalize = true (+1)" \
  "\t-C\t\t\tCapitalize = false (-1)" \
  "\t-n\t\t\tNewline = false (-1)" \
  "\t-N\t\t\tNewline = true (+1)" \
  "\t-s --speed <value>\tGet speed with the value (default 1)" \
  "\t-h --help\t\tDisplay help information" \
  "\t-v --version\t\tDisplay version"
set -l newline 1
set -l speed 1
set -l capitalize 1
set -l uppercase 0
set -l chars
argparse 'h/help' 'v/version' 'n' 'N' 'c' 'C' 's/speed=+' -- $argv || return 1
if [ -z "$argv" ]
  if [ -t 0 ] # if argv is empty and not piped
    return 1  # yo error
  end
  while read line
    set argv $argv $line
  end
  set argv "$(string join \n -- $argv)"
end

if [ (count $_flag_h) != 0 ]
  echo "Usage :" $cmd [options] [args]
  echo "Options :"
  for help in $helps_typing; echo -e  $help;end
  return
end
if [ (count $_flag_v) != 0 ]
  echo $version_typing
  return
end
[ (count $_flag_n) != 0 ];and set newline (math $newline - (count $_flag_n))
[ (count $_flag_N) != 0 ];and set newline (math $newline + (count $_flag_N))
[ (count $_flag_c) != 0 ];and set capitalize (math $capitalize + (count $_flag_c))
[ (count $_flag_C) != 0 ];and set capitalize (math $capitalize - (count $_flag_C))
[ (count $_flag_s) != 0 ]
and for i in $_flag_s
  if string match -rq '^(\-)?([0-9]+)|([0-9]+\.[0-9]+)|(\.[0-9]+)$' -- $i
    if [ $i = $_flag_s[1] ]
      set speed $i
    else
      set speed (math $speed + $i)
    end
  else
    echo -e $red2'UNKNOWN VALUE OF SPEED ANYING!!!!'$normal
    return 1
  end
end
if [ (math $speed '*' -1) -ge 0 ]
  echo $red2'BISA NGITUNG GASII???'$normal
  return 1
end
for i in (seq (count $argv))
  if [ $i = (count $argv) ]
    if [ $i = 1 ]
      set chars $argv\n
    else
      set chars $chars' '$argv[$i]\n
    end
  else
    if [ $i = 1 ]
      set chars $argv[$i]
    else
      set chars $chars' '$argv[$i]
    end
  end
end
set chars (string split '' -- $chars)
for j in (seq (count $chars))
  set char $chars[$j]
  if [ $capitalize -gt 0 ]
    if [ $j = 1 ]
      and string upper -q -- (string lower -- $char)
      set char (string upper -- (string lower -- $char))
    else if [ $uppercase = 1 ]
      and [ $char != \n ]
      if [ $chars[(math $j - 1)] = ' ' ]
        or [ $chars[(math $j - 1)] = \t ]
        if string upper -q -- (string lower -- $char)
          set char (string upper -- (string lower -- $char))
          set uppercase 0
        end
      end
    else if [ $uppercase = newline ]
      if string upper -q -- (string lower -- $char)
        set char (string upper -- (string lower -- $char))
        set uppercase 0
      end
    end
  end
  printf "%s" $char
  if [ $char != ' ' ]
    if [ $char = "-" ]
      or [ $char = "=" ]
        sleep (math 0.0075 / $speed)
    else if [ $char = '.' ]
      or [ $char = '!' ]
      or [ $char = '?' ]
      set uppercase 1
      sleep (math 0.25 / $speed)
    else if [ $char = \n ]
      if [ $j != 1 ]
        if [ $chars[(math $j - 1)] = '.' ]
          or [ $chars[(math $j - 1)] = '?' ]
          or [ $chars[(math $j - 1)] = '!' ]
          set uppercase newline
          sleep (math 0.25 / $speed)
        end
      else
        sleep (math 0.05 / $speed)
      end
    else if [ $char = ',' ]
      or [ $char = ':' ]
      or [ $char = ';' ]
      sleep (math 0.175 / $speed)
    else
      sleep (math 0.05 / $speed)
    end
  end
end
