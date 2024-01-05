#!/bin/bash

echo "Working directory is $(dirname "$0")"
echo "Download ffmpeg from https://ffmpeg.org/download.html and place it in the working directory."

PS3='Please enter your choice:'
options=("Quit" "Convert Original" "Convert Down to 1080" "Convert Down to 720" "Convert Down to 480" "Convert Whole Folder - Original" "Convert Whole Folder - 720")
select opt in "${options[@]}"
do
	case $opt in
		"Quit")
			break
			;;
		"Convert Original")
			echo ""
			echo -e "drag video here"
			echo ""
			echo ""
			read entry
            `dirname $0`/ffmpeg -i "$entry" -movflags faststart -vcodec h264 -acodec aac "$entry"n.mp4
			;;
		"Convert Down to 1080")
			echo ""
			echo -e "drag video here"
			echo ""
			echo ""
			read entry
            `dirname $0`/ffmpeg -i "$entry" -vf scale=-1:1080 -movflags faststart -vcodec h264 -acodec aac "$entry"n.mp4
			;;
        "Convert Down to 720")
			echo ""
			echo -e "drag video here"
			echo ""
			echo ""
			read entry
            `dirname $0`/ffmpeg -i "$entry" -vf scale=-1:720 -movflags faststart -vcodec h264 -acodec aac "$entry"n.mp4
			;;
        "Convert Down to 480")
			echo ""
			echo -e "drag video here"
			echo ""
			echo ""
			read entry
            `dirname $0`/ffmpeg -i "$entry" -vf scale=-2:480 -movflags faststart -vcodec h264 -acodec aac "$entry"n.mp4
			;;
		"Convert Whole Folder - Original")
			echo ""
			echo -e "drag folder here"
			echo ""
			echo ""
			read entry
            for i in "$entry"/*.*; do 
				`dirname $0`/ffmpeg -i "$i" -movflags faststart -vcodec h264 -acodec aac "${i}n.mp4"; 
			done
			;;
		"Convert Whole Folder - 720")
			echo ""
			echo -e "drag folder here"
			echo ""
			echo ""
			read entry
            for i in "$entry"/*.*; do 
				`dirname $0`/ffmpeg -i "$i" -vf scale=-1:720 -movflags faststart -vcodec h264 -acodec aac "${i}n.mp4"; 
			done
			;;
		*) echo "invalid option $REPLY";;
	esac
done