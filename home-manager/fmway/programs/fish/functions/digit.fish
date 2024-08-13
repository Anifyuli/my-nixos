# @description to print digit of string
for arg in $argv
  dig=0 i=$argv while true
    set dig (math $dig + 1)
    set i (math -s 0 $i / 10)
    if test $i -eq 0
      echo $dig
      break
    end
  end
end
