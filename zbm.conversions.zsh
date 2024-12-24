#!/usr/bin/zsh

##*********************************************
##*********************************************
##
##	CONVERSIONS a collection of conversion utilities
##
##*********************************************
##*********************************************
if [[ "${1}" == "-h" ]]
then
	echo "ZBM.CONVERSIONS"
	echo "Provides the function base2base which converts any numbers from"
	echo "one base between 2 and 36 to another. Also provided are aliases"
	echo "to run base2base with defaults for binary, octal, decimal and hex"
	echo "conversions in both ways:"
	echo "	base2base <input base> <output base> <number to convert> [<number>...]"
	echo "	dec2hex <number> [<number>...]	from decimal to hex"
	echo "	hex2dec 			from hex to decimal"
	echo "	dec2oct 			from decimal to octal"
	echo "	oct2dec 			from octal to decimal"
	echo "	dec2bin 			from decimal to binary"
	echo "	bin2dec 			from binary to decimal"
	echo "	oct2bin 			from octal to binary"
	echo "	bin2oct 			from binary to octal"
	echo "	hex2bin 			from hex to binary"
	echo "	bin2hex 			from binary to hex"
	echo "	2hex    			from decimal to hex"
	echo "	tohex   			from decimal to hex"
	echo "	2dec    			from hex to decimal"
	echo "	todec   			from hex to decimal"
	echo "	2oct    			from decimal to octal"
	echo "	tooct   			from decimal to octal"
	echo "	2bin    			from decimal to binary"
	echo "	tobin   			from decimal to binary"
	echo "	d2b     			from decimal to binary"
	echo "	h2b     			from hex to binary"
	echo "	o2b     			from octal to binary"
	echo "	d2h     			from decimal to hex"
	echo "	d2o     			from decimal to octal"
fi
function base2base()
{
	#convert numbers in any base (2 through 32) (integer) to another base (also 2 through 32)
	if [[ $# -lt 3 ]]
	then
		print "Usage:"
		print "	base2base <input base> <output base> <number> [<number>...]"
		print "Where:"
		print "	<input base> is the numerical base of the input number between 2 and 36."
		print "	<output base> is the base for the output/conversion with the same limits."
		print "	<number> is the number to convert."
		print "For example:"
		print "	To convert ff1a from hexadecimal (base 16) to decimal (base 10) use:"
		print "		base2bae 16 10 ff1a"
		print "	"
		return
	fi
	setopt C_BASES
	setopt OCTAL_ZEROES
	local bmin=2
	local bmax=36
	local inbase=${1}
	local outbase=${2}
	shift 2
	if [[ ${inbase} -ge ${bmin} && ${inbase} -le ${bmax} ]]
	then
		if [[ ${outbase} -ge ${bmin} && ${outbase} -le ${bmax} ]]
		then
			typeset -i ${outbase} converted
			while [[ -n "${1}" ]]
			do
				(( converted = ${inbase}#${1} ))
				print ${converted}
				shift
			done
		else
			echo "Output base (${outbase}) must be between ${bmin} and ${bmax}." 1>&2
		fi
	else
		echo "Input base (${inbase}) must be between ${bmin} and ${bmax}." 1>&2
	fi
}

alias dec2hex="base2base 10 16"
alias hex2dec="base2base 16 10"
alias dec2oct="base2base 10 8"
alias oct2dec="base2base 8 10"
alias dec2bin="base2base 10 2"
alias bin2dec="base2base 2 10"
alias oct2bin="base2base 8 2"
alias bin2oct="base2base 2 8"
alias hex2bin="base2base 16 2"
alias bin2hex="base2base 2 16"

alias 2hex=dec2hex
alias tohex=dec2hex
alias 2dec=hex2dec
alias todec=hex2dec
alias 2oct=dec2oct
alias tooct=dec2oct
alias 2bin=dec2bin
alias tobin=dec2bin
alias d2b=dec2bin
alias h2b=hex2bin
alias o2b=oct2bin
alias d2h=dec2hex
alias d2o=dec2oct
##*********************************************
##*********************************************
##
##	END OF CONVERSIONS
##
##*********************************************
##*********************************************
