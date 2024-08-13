set terk $status
if [ $_ = fish ]
  if test $terk != 0
    echo 'ᕙ( ̿▀̿益▀̿)╭∩╮' (basename (prompt_pwd))
  else
    echo \[ (basename (prompt_pwd)) \] 'ʚ•͜͡ )͜͡ )❨'
  end
else
  echo \{ (basename (prompt_pwd)) \}' : ' $_
end
