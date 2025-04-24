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
			# will cd the first of ~/tmp, ~/downloads, ~/Downloads, or ~/ found
			# before downloading the video specified.
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
			xytdl "$@"
			cd ${owd}
		}
		function xcleanurl
		{
			# will strip extra parameters from any youtube urls
			# will also only use https in resulting urls, regardless of original
			local xurl="${1}"
			if [[ "${xurl}" =~ 'youtube\.com\/' ]]
			then
				local video=$(echo "${xurl}" | awk '-Fv=' '{print $2}'| awk '-F&' '{print $1}')
				xurl="https://www.youtube.com/watch?v=${video}"
			elif [[ "${xurl}" =~ 'youtube-nocookie\.com\/' ]]
			then
				local video=$(echo "${xurl}" | awk '-Fembed/' '{print $2}'| awk '-F?' '{print $1}')
				xurl="https://www.youtube-nocookie.com/embed/${video}"
			elif [[ "${xurl}" =~ 'youtu.be\/' ]]
			then
				local video=$(echo "${xurl}" | awk '-Fyoutu.be/' '{print $2}'| awk '-F?' '{print $1}')
				xurl="https://youtu.be/${video}"
			fi
			echo "${xurl}"
		}
		function xytdl
		{
			if [[ "$#" -ne 2 ]]
			then
				ytdl-usage
			else
				local resolution="$1"
				shift 1
				while [[ "${1}" ]]
				do
					local url="$(xcleanurl "${1}")"
					echo "Downloading \"${url}\""
					yt-dlp --merge-output-format mkv   -f "(bestvideo[height=${resolution}])+(bestaudio)" "${url}"
					if [[ ! $? -eq 0 ]]
					then
						echo "Did not download video in ${resolution}p height. Trying width..."
						yt-dlp --merge-output-format mkv   -f "(bestvideo[width=${resolution}])+(bestaudio)" "${url}"
					fi
					shift 1
				done
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
		alias xy7='xytdl 720'
		alias y10='ytdl 1080'
		alias xy10='xytdl 1080'
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

