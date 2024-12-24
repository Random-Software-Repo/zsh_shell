#!/usr/bin/zsh

##*********************************************
##*********************************************
##
##	ZSH Replaces old commands with newer, better alternatives
##
##	The newer commands are often not option-compatible with their
##	predecessors, and so may or may not be acceptable alternatives
##	Those replacements that deviate farther from the originals
##	will not be enabled by default
##*********************************************
##*********************************************
#
#

## CAT
	if (( $+commands[bat] || $+commands[batcat] ))
	then
		if (( $+commands[batcat] ))
		then
			bcat=batcat
		else
			bcat=bat
		fi
		#alias cat="${bcat} -p --paging never --theme=Monokai\ Extended\ Bright" 
		alias cat="${bcat} --tabs 4 --color always --theme=Monokai\ Extended\ Bright"
		alias less=cat
		export PAGER="${bcat} --tabs 4 --color always --theme=Monokai\ Extended\ Bright"
	fi

## TOP / HTOP / GLANCES
	if (( $+commands[htop] ))
	then
		alias top=htop
	fi

## LS
	# LS is handled in the zb module zbm.ls.zsh


## MV
if [[ -e /bin/mv ]]
then
	alias mv='/bin/mv'  # zsh has a built in mv alias. using the system mv instead
fi
alias mc='mv'  #mc=mv common typo, for those who never use midnight commander

## DU
	#alias du=ncdu		#don't do this. ncdu is not at all a drop in replacement for du

## DIFF
if (( $+commands[delta] ))
then
		alias diff='delta'
fi

## VI / VIM / NVIM
	if (( $+commands[nvim] ))
	then
		alias vi='nvim'
		alias vim='nvim'
	elif (( $+commands[vim] ))
	then
		alias vi=vim
	fi

## WHICH and WHERE
	alias which='type'
	alias where='type -a'

## CAL and GCAL  (Calendars, not calculators)
# Uncomment and Set "CalDAV" to any value to use khal instead of pal
#CalDAV=khal
if [[ -v CalDAV && "(( $+commands[khal] ))" -eq 1 ]]
then
	## KHAL is a CalDAV client if you have access to a CalDAV calendar system
	##	such as NextCloud, OwnCloud, DavMail (outlook), google, icloud, and others.
	##	khal: https://github.com/pimutils/khal
	##	vdirsynce: https://vdirsyncer.pimutils.org/en/stable/tutorial.html
	alias cal=khal
	alias gcal=khal
elif (( $+commands[pal] ))
then
	alias cal='pal -r 0-1'
	alias gcal='pal -r 0-1'
fi


## Elinks is dead with the last non-stable release in 2012. Use links or lynx instead 
if (( $+commands[links] ))
then
	alias elinks=links
elif (( $+commands[lynx] ))
then
	alias elinks=lynx
fi