#!/usr/bin/zsh

# .zshrc
##*********************************************
##*********************************************
##
##	ZSH Common ENVIRONMENT suitable for all users
##
##*********************************************
##*********************************************

##APPLICATION ENVIRONMENT VARIABLES

#gnu make: ensure parallel processing with #cpus enabled by default
if [[ -e /proc/cpuinfo ]]
then
	export MAKEFLAGS="-j $(grep -c '^processor' /proc/cpuinfo)"
elif [[ -e /etc/os-release ]]
then
	freebsd=$(grep -i FreeBSD /etc/os-release)
	if [[ $freebsd ]]
	then
		export MAKEFLAGS="-j $(sysctl hw.ncpu| awk '{print $2}')"
	fi
fi

export GZIP="-9"

#export GREP_OPTIONS=--color=auto ##depricated
export GREP_COLOR=31

##GENERAL ENVIRONMENT
if [[ -n "${PAGER}" ]]
then
	export PAGER=less
	export LESS="-IsMR"
fi
if [[ -n "${MANPAGER}" ]]
then
	export MANPAGER="less -isX"
fi

if (( $+commands[nvim] ))
then
	export EDITOR=nvim
else
	export EDITOR=vi
fi
setopt AUTO_REMOVE_SLASH 
setopt NO_HUP


#### Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'       # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[01;32m'       # begin underline

#### Key bingings
bindkey '^[' pound-insert

##*********************************************
##*********************************************
##
##	END ZSH/BASH/KSH Common ENVIRONMENT
##
##*********************************************
##*********************************************
