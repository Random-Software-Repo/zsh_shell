#!/usr/bin/zsh

##*********************************************
##*********************************************
##
##	ZSH functions and aliases for manipulating  
##	bitmapped images (jpg, png, bmp, gif, etc.)
##
##*********************************************
##*********************************************
#
#
#	Most of these functions use ImageMagick except
#	for the scale functions. Those use ffmpeg for 
#	scaling images (ffmpeg is far more capable and)
#	much more memory efficient than imagemacick).

if (( $+commands[convert] ))
then
	function convertimage
	{
		newformat="$1"
		shift
		for inputfile in "$@"
		do
			outputfile=${inputfile%.*}.${newformat}
			#echo Converting $inputfile to $outputfile
			convert "$inputfile" -quality 85 "$outputfile"
		done	
	}
	function convert2jpg
	{
		convertimage jpg "$@"
	}
	alias c2jpg='convert2jpg'
	function convert2png
	{
		convertimage png "$@"
	}
	alias c2png='convert2png'

	function rotate90
	{
		#echo $@
		for i in "$@"
		do
			tempfilename="${i}.resized.${i##*.}"
			#echo "$i"
			convert -rotate -90 -quality 85 "$i" "${tempfilename}"
			if [[ -r "${tempfilename}" ]]
			then
				chmod "--reference=$i" "${tempfilename}"
				rm -f "$i"
				mv "${tempfilename}" "$i"
			fi
		done

	}
fi

if (( $+commands[ffmpeg] ))
then
	function scale
	{
		if [[ "$#" -lt 3 ]]
		then
			print "Usage:"
			print ""
			print "scale <width> <height> <image file name> [<image file name>...]"
			print ""
			print "SCALE scales an image (in any format ffmpeg recognizes) in place, that is"
			print "the new file will replace the original file. Images will maintain their"
			print "original aspect ratio and will be scaled to fit within the width and height"
			print "dimensions specified on the command line (in pixels)."
			print ""
			print "Currently, the compression level on the output will be the default"
			print "compression level ffmpeg uses for the relevant image type. These differ"
			print "between formats (i.e. default compression for a jpeg is different"
			print "than that for a png or webp etc.)."
		else
			wsize=${1}
			hsize=${2}
			shift 2
			for i in "$@"
			do
				tempfilename="${i}.resized.${i##*.}"
				#echo "${i}"

				ffmpeg -i "${i}" -vf scale=w=${wsize}:h=${hsize}:force_original_aspect_ratio=decrease,crop='iw-mod(iw\,2)':'ih-mod(ih\,2)' "${tempfilename}"

				if [[ -r "${tempfilename}" ]]
				then
					chmod "--reference=${i}" "${tempfilename}"
					rm -f "$i"
					mv "${tempfilename}" "${i}"
				fi
			done
		fi
	}
	function scale4096
	{
		scale "4096" "3072" "$@"
	}
	function scale2048
	{
		scale "2048" "1536" "$@"
	}
	function scale1024
	{
		scale "1024" "768" "$@"
	}
	function scale1920
	{
		scale "1920" "1080" "$@"
	}
	function scale1280
	{
		scale "1280" "720" "$@"
	}
	function scale640
	{
		scale "640" "480" "$@"
	}
fi




##*********************************************
##*********************************************
##
##	END OF ZBM.IMAGES
##
##*********************************************
##*********************************************
