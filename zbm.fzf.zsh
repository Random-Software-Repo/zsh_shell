#!/usr/bin/zsh
##*********************************************
##*********************************************
##
##	FZF ALIASES AND FUNCTIONS AND ENVIRONMENT, ZSH ONLY
##

if (( $+commands[fzf] ))
then
	if (( $+commands[bat] ))
	then
		alias fzf="command fzf --preview='bat -p --tabs 4 --color always --theme=Monokai\ Extended\ Bright {}'"
	elif (( $+commands[batcat] ))
	then
		alias fzf="command fzf --preview='batcat -p --tabs 4 --color always --theme=Monokai\ Extended\ Bright {}'"
	fi
fi
