#!/bin/bash

echo "Working directory is $(dirname "$0")"
echo "Download ffmpeg from https://ffmpeg.org/download.html and place it in the working directory."

PS3='Please enter your choice:'
options=("Quit" "Convert Original" "Convert Down to 1080" "Convert Down to 720" "Convert Down to 480" "Convert Whole Folder - Original" "Convert Whole Folder - 720" "Convert to HEVC" "Convert to HEVC_1280*720" "Convert to HEVC_720*1280" "Convert Whole Folder - HEVC" "Convert Whole Folder - HEVC_720")
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
            `dirname $0`/ffmpeg -i "$entry" -movflags faststart -vcodec h264_videotoolbox -acodec aac "$entry-n.mp4"
			echo "Conversion completed."
			;;
		"Convert Down to 1080")
			echo ""
			echo -e "Drag video here: "
			read entry
            `dirname $0`/ffmpeg -i "$entry" -vf scale=-1:1080 -movflags faststart -vcodec h264_videotoolbox -acodec aac "$entry-n_1080.mp4"
			echo "Conversion completed."
			;;
        "Convert Down to 720")
			echo ""
			echo -e "Drag video here: "
			read entry
            `dirname $0`/ffmpeg -i "$entry" -vf scale=-1:720 -movflags faststart -vcodec h264_videotoolbox -acodec aac "$entry-n_720.mp4"
			echo "Conversion completed."
			;;
        "Convert Down to 480")
			echo ""
			echo -e "Drag video here: "
			read entry
            `dirname $0`/ffmpeg -i "$entry" -vf scale=-2:480 -movflags faststart -vcodec h264_videotoolbox -acodec aac "$entry-n_480.mp4"
			echo "Conversion completed."
			;;
		"Convert Whole Folder - Original")
			echo ""
			echo -e "drag folder here"
			read -e entry
			shopt -s nocaseglob  # Enable case-insensitive globbing
			for i in "$entry"/*.{mp4,mov,avi,wmv,mkv,webm,mts,ts,flv}; do
			if [[ -f "$i" ]]; then
				`dirname $0`/ffmpeg -i "$i" -movflags faststart -vcodec h264_videotoolbox -acodec aac "$i-n.mp4"; 
			else
				echo "Skipping non-file: $i" >&2  # Indicate non-file items
			fi
			done
			shopt -u nocaseglob  # Disable case-insensitive globbing
			echo "Conversion completed."
			;;
		"Convert Whole Folder - 720")
			echo ""
			echo -e "drag folder here"
			read -e entry
			shopt -s nocaseglob  # Enable case-insensitive globbing
			for i in "$entry"/*.{mp4,mov,avi,wmv,mkv,webm,mts,ts,flv}; do
			if [[ -f "$i" ]]; then
				`dirname $0`/ffmpeg -i "$i" -vf scale=-1:720 -movflags faststart -vcodec h264_videotoolbox -acodec aac "$i-n_720.mp4";
			else
				echo "Skipping non-file: $i" >&2  # Indicate non-file items
			fi
			done
			shopt -u nocaseglob  # Disable case-insensitive globbing
			echo "Conversion completed."
			;;
		"Convert to HEVC")
			echo -e "Drag video here: "
			read entry
			`dirname $0`/ffmpeg -y -i "$entry" -movflags faststart -c:v hevc_videotoolbox -tag:v hvc1 -acodec aac "$entry-n265.mp4"
			# Using hevc_videotoolbox to use Apple Silicon hardware acceleration
			# `dirname $0`/ffmpeg -i "$entry" -movflags faststart -vcodec libx265 -crf 23 -preset fast -x265-params pass=2 -tag:v hvc1 -acodec aac "$entry"n.mp4
			echo "Conversion completed."
			;;
		"Convert to HEVC_1280*720")
			echo -e "Drag video here: "
			read entry
			`dirname $0`/ffmpeg -i "$entry" -movflags faststart -c:v hevc_videotoolbox -tag:v hvc1 -vf scale=1280:720 -acodec aac "$entry-n265_720.mp4"
			echo "Conversion completed."
			;;
		"Convert to HEVC_720*1280")
			echo -e "Drag video here: "
			read entry
			`dirname $0`/ffmpeg -i "$entry" -movflags faststart -c:v hevc_videotoolbox -tag:v hvc1 -vf scale=720:1280 -acodec aac "$entry-n265_720.mp4"
			echo "Conversion completed."
			;;
		"Convert Whole Folder - HEVC")
			echo -e "drag folder here: "
			read -e entry
			shopt -s nocaseglob  # Enable case-insensitive globbing
			for i in "$entry"/*.{mp4,mov,avi,wmv,mkv,webm,mts,ts,flv}; do
			if [[ -f "$i" ]]; then
				`dirname $0`/ffmpeg -i "$i" -movflags faststart -c:v hevc_videotoolbox -tag:v hvc1 -acodec aac "$i-n265.mp4"
			else
				echo "Skipping non-file: $i" >&2  # Indicate non-file items
			fi
			done
			shopt -u nocaseglob  # Disable case-insensitive globbing
			echo "Conversion completed."
			;;
		"Convert Whole Folder - HEVC_720")
			echo -e "drag folder here: "
			read -e entry
			shopt -s nocaseglob  # Enable case-insensitive globbing
			for i in "$entry"/*.{mp4,mov,avi,wmv,mkv,webm,mts,ts,flv}; do
			if [[ -f "$i" ]]; then
				`dirname $0`/ffmpeg -i "$i" -movflags faststart -c:v hevc_videotoolbox -tag:v hvc1 -vf scale=1280:720 -acodec aac "$i-n265_720.mp4"
			else
				echo "Skipping non-file: $i" >&2  # Indicate non-file items
			fi
			done
			shopt -u nocaseglob  # Disable case-insensitive globbing
			echo "Conversion completed."
			;;
		*) echo "invalid option $REPLY";;
	esac
done
