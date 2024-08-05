# @description remove audio from a video
ffmpeg -i $argv[1] -c copy -an $argv[2]
