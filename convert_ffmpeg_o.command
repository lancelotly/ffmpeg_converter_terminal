#!/bin/bash

echo "Working directory is $(dirname "$0")"
echo "Download ffmpeg from https://ffmpeg.org/download.html and place it in the working directory."

PS3='Please enter your choice:'
options=("Quit" "Convert Original" "Convert Down to 1080" "Convert Down to 720" "Convert Down to 480" "Convert Whole Folder - Original" "Convert Whole Folder - 720" "Convert to HEVC" "Convert Whole Folder - HEVC")
select opt in "${options[@]}"
do
	case $opt in
		"Quit")
			break
			;;
		"Convert Original")
			echo ""
			echo -e "Drag video here: "
			read entry
            `dirname $0`/ffmpeg -i "$entry" -movflags faststart -vcodec h264 -acodec aac "${entry%.*}-n.mp4"
			echo "Conversion completed."
			;;
		"Convert Down to 1080")
			echo ""
			echo -e "Drag video here: "
			read entry
            `dirname $0`/ffmpeg -i "$entry" -vf scale=-1:1080 -movflags faststart -vcodec h264 -acodec aac "${entry%.*}-n.mp4"
			echo "Conversion completed."
			;;
        "Convert Down to 720")
			echo ""
			echo -e "Drag video here: "
			read entry
            `dirname $0`/ffmpeg -i "$entry" -vf scale=-1:720 -movflags faststart -vcodec h264 -acodec aac "${entry%.*}-n.mp4"
			echo "Conversion completed."
			;;
        "Convert Down to 480")
			echo ""
			echo -e "Drag video here: "
			read entry
            `dirname $0`/ffmpeg -i "$entry" -vf scale=-2:480 -movflags faststart -vcodec h264 -acodec aac "${entry%.*}-n.mp4"
			echo "Conversion completed."
			;;
		"Convert Whole Folder - Original")
			echo ""
			echo -e "drag folder here"
			read -e entry
			for i in "$entry"/*.{mp4,mov,avi,wmv,mkv,webm,MTS}; do
			if [[ -f "$i" ]]; then
				`dirname $0`/ffmpeg -i "$i" -movflags faststart -vcodec h264 -acodec aac "${i%.*}-n.mp4"; 
			else
				echo "Skipping non-file: $i" >&2  # Indicate non-file items
			fi
			done
			echo "Conversion completed."
			;;
		"Convert Whole Folder - 720")
			echo ""
			echo -e "drag folder here"
			read -e entry
            for i in "$entry"/*.{mp4,mov,avi,wmv,mkv,webm,MTS}; do
			if [[ -f "$i" ]]; then
				`dirname $0`/ffmpeg -i "$i" -vf scale=-1:720 -movflags faststart -vcodec h264 -acodec aac "${i%.*}-n.mp4";
			else
				echo "Skipping non-file: $i" >&2  # Indicate non-file items
			fi
			done
			echo "Conversion completed."
			;;
		"Convert to HEVC")
			echo -e "Drag video here: "
			read entry
			`dirname $0`/ffmpeg -i "$entry" -movflags faststart -vcodec libx265 -crf 23 -tag:v hvc1 -acodec aac "${entry%.*}-n265.mp4"
			# `dirname $0`/ffmpeg -i "$entry" -movflags faststart -vcodec libx265_nvenc -crf 23 -preset fast -x265-params pass=2 -tag:v hvc1 -acodec aac "$entry"n.mp4
			# `dirname $0`/ffmpeg -i "$entry" -movflags faststart -vcodec hevc_nvenc -crf 23 -preset fast -x265-params pass=2 -tag:v hvc1 -acodec aac "$entry"n.mp4
			echo "Conversion completed."
			;;
		"Convert Whole Folder - HEVC")
			echo -e "drag folder here: "
			read -e entry
			for i in "$entry"/*.{mp4,mov,avi,wmv,mkv,webm,MTS}; do
			if [[ -f "$i" ]]; then
				`dirname $0`/ffmpeg -i "$i" -vcodec libx265 -crf 23 -tag:v hvc1 -acodec aac -movflags faststart "${i%.*}-n265.mp4"
			else
				echo "Skipping non-file: $i" >&2  # Indicate non-file items
			fi
			done
			echo "Conversion completed."
			;;
		*) echo "invalid option $REPLY";;
	esac
done