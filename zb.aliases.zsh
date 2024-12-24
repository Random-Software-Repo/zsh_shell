#!/usr/bin/zsh

##*********************************************
##*********************************************
##
##	ZSH common ALIASES suitable for all users
##
##*********************************************
##*********************************************
#
#
FREEBSD=
grep -q FreeBSD /etc/os-release && FREEBSD=YES
# alias for cp
alias cp='cp -a'
# use rsync as cp
alias rcp='rsync -n -ap --stats --progress'
alias rcpslow='rsync  -ap --stats --progress --bwlimit=256m'


# aliases for gnome-open to open files
alias open='xdg-open'
alias start='open'

alias history='history -i'

# always use X11 trust forwarding with SSH.
#alias ssh='ssh -Y '

# Preserve-root in chmod and chown prevents inadvertent actions on the
# root directory (/) which ..... one *probably* doesn't intend.a
preserveroot='--preserve-root'
if [[ -n ${FREEBSD} ]]
then
	preserveroot=
fi
alias chmod="command chmod ${preserveroot} -v"
alias chown="command chown ${preserveroot} -v"

#command redefinitions
alias df='df -Th' # always show fs type and size in T/G/Mbytes as appropriate

alias bc='command bc -l'
alias netcalc='sipcalc'


# CPU Temperature & speed
if (( $+commands[sensors] ))
then
	alias cputemp='while (( 1 )) do; sensors | grep CPU; sleep 2; done;'
fi
if (( $+commands[lscpu] ))
then
	alias cpuspeed='while (( 1 )); do lscpu | grep MHz; sleep 2; done;'
fi
#CD aliases to common directories or common typos (cd.. instead of cd .. etc.)
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd......='cd ../../../../..'
alias cd.......='cd ../../../../../..'
alias cd........='cd ../../../../../../..'
alias cd.........='cd ../../../../../../../..'
alias cd..........='cd ../../../../../../../../..'
alias cd-='cd -'
if [[ -e ~/Downloads ]]; then alias cdd='cd ~/Downloads/';fi
if [[ -e ~/downloads ]]; then alias cdd='cd ~/downloads/';fi
if [[ -e ~/Pictures ]]; then alias cdP='cd ~/Pictures/';fi
if [[ -e ~/Video ]]; then alias cdV='cd ~/Videos/';fi
if [[ -e ~/Music ]]; then alias cdM='cd ~/Music';alias cdm=cdM;fi
if [[ -e ~/Games ]]; then alias cdG='cd ~/Games';fi
if [[ -e ~/bin ]]; then alias cdb='cd ~/bin';fi
if [[ -e ~/Documents ]]; then alias cdD='cd ~/Documents/';fi
if [[ -e ~/tmp ]]; then alias cdt='cd ~/tmp/';fi
if [[ -e ~/.shells ]]; then alias cds='cd ~/.shells/';fi

if (( $+commands[inxi] ))
then
	alias about='inxi -c 9 -F'
fi

alias dug='du -sc --block-size=1G'

#Personal PS. Shows only processes owned by the current user.
alias pps='ps -u "$USER" -F'

# extra ways to logout
alias lo='exit'

#screen aliases
alias sc='screen -d -R'

alias fortune='command fortune /usr/local/share/quotes'


##*********************************************
##*********************************************
##
##	END OF ALIASES suitable for all users
##
##*********************************************
##*********************************************
