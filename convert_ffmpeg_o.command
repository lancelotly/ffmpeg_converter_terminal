#!/usr/bin/env bash
echo "Working direct is `dirname $0`, you should put ffmpeg file and this COMMAND file together here. Download ffmpeg from its official site @ https://ffmpeg.org/download.html"
PS3='Please enter your choice: "1. Convert Original" "2. Convert Down to 720" "3. Convert Down to 480" "4. Convert Whole Folder" "5. Quit"'
options=("Convert Original" "Convert Down to 720" "Convert Down to 480" "Convert Whole Folder" "Quit")
select opt in "${options[@]}"
do
	case $opt in
		"Convert Original")
			echo ""
			echo -e "drag video here"
			echo ""
			echo ""
			read entry
            `dirname $0`/ffmpeg -i "$entry" -movflags faststart -vcodec h264 -acodec aac "$entry"n.mp4
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
		"Convert Whole Folder")
			echo ""
			echo -e "drag folder here"
			echo ""
			echo ""
			read entry
            for i in "$entry"/*.*; do 
				`dirname $0`/ffmpeg -i "$i" -movflags faststart -vcodec h264 -acodec aac "${i}n.mp4"; 
			done
			;;
		"Quit")
			break
			;;
		*) echo "invalid option $REPLY";;
	esac
done