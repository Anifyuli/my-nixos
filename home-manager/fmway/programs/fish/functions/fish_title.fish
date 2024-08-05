set terk $status
if [ $_ = fish ]
  if test $terk != 0
    echo '(☞ ̿▀̿ ͜ʖ▀̿)☞' '╭∩╮(▀̿益▀̿ ̿)ᕗ'
  else
    echo '(✧Д✧)→' (basename (prompt_pwd))
  end
else
  echo '(☞ ̿▀̿ ͜ʖ▀̿)☞' '☜( <'$_'> ☜)'
end
