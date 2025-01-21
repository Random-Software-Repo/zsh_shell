#!/usr/bin/zsh
##*********************************************
##*********************************************
##
##	MEDIA FUNCTIONS
##
##
##	Prequisits:
##		Editing FLAC files:	metaflac		(installed with the flac package)
##		Editing MP3 files:	id3v2			(id3v2 package)
##		Editing OGG files:	vorbiscomment	(installed with the vorbis-tools package)
##
##		LISTING MP3/OGG files:	exiftool	(installed with the libimage-exiftool-perl package)
##
##*********************************************
##*********************************************
if [[ "(( $+commands[id3v2] ))" -eq 1 && "(( $+commands[metaflac] ))" -eq 1 && "(( $+commands[vorbiscomment] ))" -eq 1 && "(( $+commands[exiftool] ))" -eq 1 ]]
then
	function settag()
	{
		if [[ $# -lt 3 ]]
		then
			echo "Usage:"
			echo "        $0 <tag> <value> <files>"
			echo " "
			echo "         where <tag> is one of: artist, album, title, tracknumber,"
			echo "         genre, year or comment. The tag must be lowercase."
			echo ""
			echo "         $0 can operate on .mp3, .ogg and .flac files only at this time."
			echo ""
			echo "    SETTAG requires the 'metaflac' and 'id3v2' and 'vorbiscomment'  "
			echo "    supporting programs to operate on flac, mp3 and ogg files respectively."
			return
		fi
		field=$1
		shift
		value=$1
		shift
		while [ "$1" ]
		do
			echo Setting "$field" to "$value" for track "$1"
			extension=${1:e:l}
			if [[ "$extension" == "mp3" ]]
			then
				# an mp3 file
				case "$field" in
					'artist')
						option=artist
						;;
					'album')
						option=album
						;;
					'title')
						option=song
						;;
					'tracknumber')
						option=track
						;;
					'genre')
						option=genre
						# mp3id3 can handle genres in numeric as well as string format.
						;;
					'year')
						option=year
						;;
					'comment')
						option=comment
						;;
				esac
				id3v2 --${option} "$value" "$1"
			elif [[ "$extension" == "flac" ]]
			then
				# a flac file
				case "$tag" in
					'artist')
						option=ARTIST
						;;
					'album')
						option=ALBUM
						;;
					'title')
						option=TITLE
						;;
					'tracknumber')
						option=TRACKNUMBER
						;;
					'genre')
						option=GENRE
						;;
					'year')
						option=DATE
						;;
					'comment')
						option=COMMENT
						;;
				esac
				# Flac files accept multiple tags, so if one does not remove any previous tag
				# it will remain when adding anew tag. So we remove the tag first. 
				metaflac --remove-tag="$option" "$1"
				metaflac --set-tag="$option"="$value" "$1"
			elif [[ "$extension" =~ "ogg" ]]
			then
				# an ogg file
				case "$tag" in
					'artist')
						option=ARTIST
						;;
					'album')
						option=ALBUM
						;;
					'title')
						option=TRACK
						;;
					'tracknumber')
						option=TRACKNUMBER
						;;
					'genre')
						option=GENRE
						;;
					'year')
						option=DATE
						;;
					'comment')
						option=COMMENT
						;;
				esac
				vorbiscomment -wt "$option=$value" "$1"
			else
				# an unknown file
				echo "$1 is not of a supported type ($extension)."
			fi
			shift 1
		done
	}
	#### Flac/mp3 id3v2 Metadata manipulation functions to make bulk (and individual) edits
	#### practical and easy.
	function setartist()
	{
		t1="$1"
		shift
		settag artist "$t1" "$@"
	}
	function setgenre()
	{
		t1="$1"
		shift
		settag genre "$t1" "$@"
	}
	function setalbum()
	{
		t1="$1"
		shift
		settag album "$t1" "$@"
	}
	function setyear()
	{
		t1="$1"
		shift
		settag year "$t1" "$@"
	}
	function settracknumber()
	{
		t1="$1"
		shift
		settag tracknumber "$t1" "$@"
	}

	function getflacfield()
	{
		rawvalue=$(metaflac --show-tag=$1 "$2")
		value=$rawvalue[(ws:=:)2]
		echo $value
	}


	function addflac()
	{
		field=$1
		shift
		value=$1
		shift
		while [ "$1" ]
		do
			echo Setting "$field" to "$value" for track "$1"
			metaflac --set-tag="$field"="$value" "$1"
			shift
		done
	}
	function addgenre()
	{
		# add a genre to a flac file. This does NOT delete or replace
		# any existing genre attribute in the file. Use setgenre to
		# completely replace existing genre in a flac file.
		t1="$1"
		shift
		addflac GENRE "$t1" "$@"
	}

	function showtag()
	{
		if [[ $# -lt 2 ]]
		then
			echo "Usage:"
			echo "        $0 <tag> <files>"
			echo " "
			echo "         where <tag> is one of: artist, album, track, tracknumber,"
			echo "         genre, year or comment. The tag must be lowercase."
			echo ""
			echo "         $0 can operate on .mp3 and .flac files only at this time."
			echo ""
			echo "    SHOWTAG requires the 'metaflac' and 'mp3id3' supporting programs"
			echo "    to operate on flac and mp3 files respectively."
			return
		fi
		tag="$1"
		shift 1
		while [ "$1" ]
		do
			extension=${1##*.}
			# zsh only string manipulation
			extension=${extension:l}
			#echo extension=$extension
			if [[ "$extension" =~ "mp3|ogg|" ]]
			then
				# do mp3
				#echo An MP3 file. Whee.
				option=a
				case "$tag" in
					'artist')
						option=artist
						;;
					'album')
						option=album
						;;
					'title')
						option=title
						;;
					'tracknumber')
						option=track
						;;
					'genre')
						option=genre
						;;
					'year')
						option=year
						;;
					'comment')
						option=comment
						;;
				esac
				#echo exiftool -${option} "$1"
				echo $(exiftool -${option} "$1")

			elif [[ "$extension" =~ "flac" ]]
			then
				# do flac
				#echo A FLAC file. Whee.
				option=ARTIST
				case "$tag" in
					'artist')
						option=ARTIST
						;;
					'album')
						option=ALBUM
						;;
					'title')
						option=TITLE
						;;
					'tracknumber')
						option=TRACKNUMBER
						;;
					'genre')
						option=GENRE
						;;
					'year')
						option=DATE
						;;
					'comment')
						option=COMMENT
						;;
				esac
				#echo metaflac --show-tag=$option \"$1\"
				metaflac --show-tag=$option "$1"
			else
				echo "$1 is not a supported type ($extension)"
			fi
			shift 1
		done
	}
	function showartist()
	{
		showtag artist "$@"
	}
	function showalbum()
	{
		showtag album "$@"
	}
	function showtitle()
	{
		showtag title "$@"
	}
	function showgenre()
	{
		showtag genre "$@"
	}
	function showyear()
	{
		showtag year "$@"
	}
	function showtracknumber()
	{
		showtag tracknumber "$@"
	}
	function showcomment()
	{
		showtag comment "$@"
	}
	function printtimefromseconds()
	{
		local lensecs=${1}
		local hours=0
		local minutes=0
		local seconds=0
		local mpad=
		local hourstring=
		local spad=
		((hours = lensecs / 3600 ))
		((lensecs = lensecs - (hours * 3600) ))
		((minutes = lensecs / 60 ))
		((seconds = lensecs - (minutes * 60) ))
		if [[ $hours -gt 0 ]]
		then
			mpad=
			if [[ $minutes -lt 10 ]]
			then
				mpad=0
			fi
			hourstring=$hours:$mpad
		fi

		spad=
		if [[ $seconds -lt 10 ]]
		then
			spad=0
		fi

		#echo Sample Rate: $samplerate
		#echo Total Samples: $samples
		echo $hourstring$minutes:$spad$seconds
		
	}
	function flactime()
	{
		# displays the playing time for a give flac
		# file (or files) in [hours:]minutes:seconds
		# if the track is less than an hour long the
		# hours portion will not be printed.
		typeset -i samplerate
		typeset -i samples
		##typeset -i bps
		typeset -i lensecs
		typeset -i hours
		typeset -i minutes
		typeset -i seconds

		dosum=
		totalseconds=0
		if [[ "${1}" == "-s" ]]
		then 
			dosum=yes
			shift
		fi 
		

		while [ "${1}" ]
		do
			hourstring=
			samplerate=$(metaflac --show-sample-rate "${1}" )
			samples=$(metaflac --show-total-samples "${1}")
			##bps=$(metaflac --show-bps "$1")
			((lensecs = samples/samplerate))
			if [ "${dosum}" ]
			then 
				((totalseconds = totalseconds + lensecs))
			else
				printtimefromseconds ${lensecs}
			fi
			shift 1
		done
		if [ "${dosum}" ]
		then 
			printtimefromseconds ${totalseconds}
		fi
	}
fi





function mkvmp3()
{
	fsource="${1}"
	ftarget=${fsource%\.*}.mkv
	ffmpeg -hide_banner -ss 0 -i "${fsource}" -c:v copy -c:a mp3 -c:s copy -map_metadata 0 -map_chapters 0 -map 0  "${ftarget}"

}

# crap functions pulled from zb.functions

function countalbums()
{
	listalbums | wc
}
function listalbums()
{
	find | awk -F "_-_|/" '{print $3":"$4}' | sort | uniq 
}
function countartists()
{	
	find | awk -F "_-_" '{print $1}' | awk -F "/" '{print $2}' | sort | uniq | wc
}
function listsartists()
{
	find | awk -F "_-_" '{print $1}' | awk -F "/" '{print $2}' | sort | uniq 
}


function mpsave
{
	# dumps the stream in $1 into file $2
	mplayer -dumpstream -dumpfile "${2}" "rtsp://${1}"
}

function dstream
{
	file="$2"
	url="$1"
	mplayer -dumpstream -dumpfile "$file" "$url"
}
##*********************************************
##*********************************************
##
##	END OF MEDIA FUNCTIONS
##
##*********************************************
##*********************************************
