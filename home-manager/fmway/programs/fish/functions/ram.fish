set -l total (cat /proc/meminfo | grep -E 'MemTotal' | awk '{print $2/1000}')
set -l free (cat /proc/meminfo | grep -E 'MemFree' | awk '{print $2/1000}')
set -l available (cat /proc/meminfo | grep -E 'MemAvailable' | awk '{print $2/1000}')
if set -q LOLCAT
  echo -n "RAM  : " | lolcat
  echo (math $total - $available)" MB / $total MB" | lolcat
else
  echo -e (rkol)"RAM  : "(set_color white)(math $total - $available)" MB / $total MB"
end
