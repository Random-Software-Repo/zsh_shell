#!/usr/bin/zsh

##*********************************************
##*********************************************
##
##	Adds aliaes to aid downloading videos from youtube using
##	youtube-dl or yt-dlp
##	on exit.
##
##*********************************************
##*********************************************
#youtube-dl
	#if [[ -e /usr/bin/yt-dlp ]]
	if (( $+commands[yt-dlp] ))
	then
		function ytdl-usage
		{
			print "Usage:"
			print "	ytdl <vertical-resolution> <url-to-video>"
			print ""
			print "ytdl attempts to download a video from a web-site (youtube, or others)"
			print "with a maximum vertical resolution of <vertical-resolution>. The video"
			print "will be downloaded into the first of ~/tmp, ~/downloads, ~/Downloads, or"
			print "~/ if none of those directories exist."
			print ""
			print "If the video is not available in the specified resolution, ytdl will"
			print "attempt to download the video using the specified resolution as a "
			print "maximum horizontal resolution instead. This may work for some videos."
		}
		function ytdl
		{
			if [[ "$#" -ne 2 ]]
			then
				ytdl-usage
			else
				local owd=${PWD}
				if [[ -d ~/tmp ]]
				then
					cd ~/tmp
				elif [[ -d ~/downloads ]]
				then
					cd ~/downloads
				elif [[ -d ~/Downloads ]]
				then
					cd ~/Downloads
				else
					cd ~/
				fi
				local resolution="$1"
				shift 1
				while [[ "${1}" ]]
				do
					yt-dlp --merge-output-format mkv   -f "(bestvideo[height=${resolution}])+(bestaudio)" "${1}"
					if [[ ! $? -eq 0 ]]
					then
						echo "Did not download video in ${resolution}p height. Trying width..."
						yt-dlp --merge-output-format mkv   -f "(bestvideo[width=${resolution}])+(bestaudio)" "${1}"
					fi
					shift 1
				done
				cd ${owd}
			fi
		}
		alias youtube-dl=yt-dlp
		alias y='yt-dlp'
		alias ya='yt-dlp -f "(bestaudio[vcodec=none])" '
		alias yv='yt-dlp --merge-output-format mkv '
		alias y3='ytdl 360'
		alias y4='ytdl 480'
		alias y5='ytdl 540'
		alias y7='ytdl 720'
		alias y10='ytdl 1080'
		alias y4k='ytdl 2160'
	elif (( $+commands[youtube-dl] ))
	then
		alias y=youtube-dl
	fi
##*********************************************
##*********************************************
##
##	END OF YOUTUBE
##
##*********************************************
##*********************************************

