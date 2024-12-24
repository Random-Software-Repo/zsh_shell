#!/usr/bin/zsh
##*********************************************
##*********************************************
##
##	ZFS ALIASES AND FUNCTIONS, ZSH ONLY
##
if (( $+commands[zfs] ))
then
	alias zfsl="zfs list -t filesystem -o space,encryption,mountpoint"
fi