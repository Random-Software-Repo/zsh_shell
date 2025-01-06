#!/usr/bin/zsh
##*********************************************
##*********************************************
##
##	ZFS ALIASES AND FUNCTIONS, ZSH ONLY
##
if (( $+commands[zfs] ))
then
	function zfsl()
	{
		# shows filesystem and volumes. replaces long 'filesystem' and 'volume' labels with 'fs' 
		# and 'v' respectively so results aren't as wide.
		# usedds is the actual spaced used by the fs/vol, not the total spaced used.
		zfs list -t vol,filesystem -o name,type,avail,usedds,encryption,canmount,mountpoint "$@" |sed 's/filesystem/fs\t/g'|sed 's/TYPE     /TYPE/g'| sed 's/volume/v/g'
	}
fi