# @description my function like uniq command
set result
set dirtylist
if [ (count $argv) -lt 1 ]
  if [ -t 0 ]
    return 1
  end
  while read line
    set dirtylist $dirtylist $line
  end
else
  set dirtylist $argv
end
# echo $dirtylist
for dirty in $dirtylist
  set __found 0
  for i in $result
    if [ "$dirty" = "$i" ]
      set __found 1
      break
    end
  end
  if [ $__found -eq 0 ]
    set result $result $dirty
  end
end
string join \n $result
