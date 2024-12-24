#!/usr/bin/zsh

##*********************************************
##*********************************************
##
##	ZSH Expanded Directory / ls functions and aliases. 
##	Uses EZA (or EXA) in place of LS if it is installed
##
##	WARNING:	THIS FILE INCLUDES AN ALIAS FOR DD THAT DOES NOT DO
##				WHAT THE SYSTEM COMMAND DD DOES. IT WON'T CAUSE ANY
##				DAMAGE, BUT MAY CAUSE FRUSTRATION IF YOU USE THE
##				SYSTEM DD FREQUENTLY.
##
##*********************************************
##*********************************************
#
#

if [[ -e "${HOME}/.shells/lscolors.sh" ]]
then
	source "${HOME}/.shells/lscolors.sh"
fi

if (( $+commands[exa] || $+commands[eza] ))
then
	## exa is a great ls replacement.... but abandoned.
	## eza is a community driven fork of exa. 
	## use eza if present, falling back on exa
	local NEWLS=exa
	if (( $+commands[eza] ))
	then
		NEWLS=eza
	fi
	# d: directory listing , long format, directories first, exclude dot files
	# da:as d,including dot files
	# ds: as d, sort by size, including dot files
	export TIME_STYLE=long-iso
	alias ls="${NEWLS} --icons"
	alias d="${NEWLS} --icons --group-directories-first -lg"
	alias da="${NEWLS} --icons --group-directories-first -lga"
	alias ds="${NEWLS} --icons --group-directories-first --sort=size -lga"

	# dd: list in reverse modified order, long format, human reabable
	#	that is, the newest/most recently modified file will be
	#	the last in the list (closest to the new prompt), includes
	#	dot files
	# ddl: as dd, show file sizes --icons in bytes
	# dds: as dd but by size rather than modified age
	alias dd="${NEWLS} --icons --group-directories-first --sort=modified -lga"
	alias ddl="${NEWLS} --icons --group-directories-first --sort=modified -lgaB"
	alias dds="${NEWLS} --icons --group-directories-first --sort=size -la"
elif (( $+commands[lsd] ))
then
	alias ls='lsd'
	alias d='lsd --group-dirs first -l'
	alias da='lsd --group-dirs first -lA'
	alias ds='lsd --group-dirs first -Sla'
	alias dd='lsd --group-dirs first -rtla'
	alias ddl='lsd --group-dirs first --size bytes -rtla'
	alias dds='lsd --group-dirs first -Srla'
else 
	# Still using LS
	function blcv
	{
		# blcv = build ls COLORs variable
		local COLOR=${1}
		shift 1
		for eparam in ${@}
		do
			#ARCHIVES="${ARCHIVES}${SEP}\*.${et}:\*.${et:u}"
			echo -n ":*.${eparam:l}=${COLOR}:*.${eparam:u}=${COLOR}"
		done
	}

	## lss is a very poor replacement for exa if it is not present
	## lss shows directory listing with directories grouped at the top.
	function lss
	{		
		#echo DIRECTORIES:
		command ls  --color=always $@ | grep $grepoption '^d[r-][w-][x-][r-][w-][x-][r-][w-][x-]'
		#command ls  $lsoption -d *(/) $@ 
		#echo FILES:
		command ls  --color=always  $@ | grep $grepoption -v '^d[r-][w-][x-][r-][w-][x-][r-][w-][x-]' | grep -v '^total [0-9]*[\.]\{0,1\}[0-9]*[BKMGTPZ]*$'
		#command ls  $lsoption -d *(^/) $@ 
		#echo TOTAL:
		command ls  --color=always  $@ | grep $grepoption '^total [0-9]*[\.]\{0,1\}[0-9]*[BKMGTPZ]*$'
	}

	alias ls='command ls  '
	alias d='lss -lhF '
	alias da='lss -lAh'
	alias ds='command ls -lhSr --color=always ' # sort by size
	#dd list in reverse size order, long format, human reabable
	# that is, the newest/most recently modified file will be
	# the last in the list (closest to the new prompt), includes
	# dot files
	alias dd='lss -lAhtr '
	alias ddl='lss -lAtr ' #shows file sizes in bytes
	alias dds='lss -Ahtr '
fi

alias dir='d'
alias dira='da'
alias ddd='dd -d *(/)' # only directories sorted by date modified


##*********************************************
##*********************************************
##
##	END OF ZBM.LS
##
##*********************************************
##*********************************************
