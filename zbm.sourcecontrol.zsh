#!/usr/bin/zsh

##*********************************************
##*********************************************
##
##	Source control (git, subversion, hg etc.) 
##
##*********************************************
##*********************************************
#
#
if (( $+commands[git] ))
then
	alias git='git --no-pager'
	alias gitl='git log --pretty=format:"%ad   [%an]     (%h)%n    %s%d" --graph --date=short | less'
	alias gits='git status'
	alias gdiff='git diff'
fi