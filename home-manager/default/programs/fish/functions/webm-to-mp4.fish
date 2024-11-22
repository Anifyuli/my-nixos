# @description move from webm to mp4
ffmpeg -i $argv[1] -c:v libx264 -preset slow -crf 22 -c:a aac -b:a 128k -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" $argv[2]
