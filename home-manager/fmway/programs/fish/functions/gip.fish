# @description get ip then print as list
set -l ips (ip a | grep inet\  | awk '{print $2}')
for i in $ips
  string split '/' $i | head -n 1
end
