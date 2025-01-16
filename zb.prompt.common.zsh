#!/usr/bin/zsh
# .zshrc
##*********************************************
##*********************************************
##
##	Elements common for all prompts.
##	
##	Many thanks to Phil and his prompt at http://aperiodic.net/phil/prompt/
##
##

## SET UP COLORS
# FX 		array of codes for effects (FX) 
# FG 		Foreground colors
# BG 		Background colors
# FGP 		Foreground colors wrapped with %{ and %} for use in the prompt (the prompt requires different encoding of colors)
# BGP 		Background colors for use in prompts
# FXP 		Effects codes for use in prompts 
typeset -Ag FX FG BG FGP BGP FXP OS_ICONS

#### array of effects codes
FX=(
	reset			"[00m"
	bold			"[01m" 
	no-bold			"[22m"
	italic			"[03m" 
	no-italic		"[23m"
	underline		"[04m" 
	no-underline	"[24m"
	blink			"[05m" 
	no-blink		"[25m"
	reverse			"[07m" 
	no-reverse		"[27m"
)
#### array of effects codes wrapped in %{ and %} for use in prompts
FXP=(
	reset			"%{$FX[reset]%}"
	bold			"%{$FX[bold]%}"
	italic			"%{$FX[italic]%}"
	underline		"%{$FX[underline]%}"
	blink			"%{$FX[blink]%}"
	reverse			"%{$FX[reverse]%}"
	no-bold			"%{$FX[no-bold]%}"
	no-italic		"%{$FX[no-italic]%}"
	no-underline	"%{$FX[no-underline]%}"
	no-blink		"%{$FX[no-blink]%}"
	no-reverse		"%{$FX[no-reverse]%}"
)
# Set up arrays of all Foreground (FG) and Background (BG) colors
# Set up arrays of all colors to be used in prompts encloded in %{ and %} 
# (FGP and BGP for forground-prompt and background-prompt respectively)
for color in {0..255}
do
	FG[$color]="[38;5;${color}m"
	FGP[$color]="%{$FG[${color}]%}"
	BG[$color]="[48;5;${color}m"
	BGP[$color]="%{$BG[${color}]%}"
done

function print_colors
{
	for color in {0..255}
	do
		(( textcolor = (color + 128) % 255 ))
		pad=""
		if (( color < 10 ))
		then
			pad="  "
		elif (( color < 100 ))
		then
			pad=" "
		fi
		echo -n -e "$BG[$color]$FG[$textcolor] ${pad}${color} $FX[reset]"
		if (( (color % 16) == 15 ))
		then
			echo ""
		fi
	done
}
## DONE SETTING UP COLORS

## SETUP OS SPECIFIC NERD-FONT ICONS FOR THE PROMPT 
## (ONLY FOR UNIX LIKE ENVIRONMENTS WHICH 
## HAVE A /etc/os-release FILE WITH A "KNOWN" ID= VALUE)
## EVEN SO, NOT ALL OF THESE HAVE NERD-FONT ICONS
#OS_ICONS[linux]=""
OS_ICONS[almalinux]=""
OS_ICONS[alpine]=""
OS_ICONS[amzn]=""
OS_ICONS[arch]=""
OS_ICONS[arcolinux]=""
OS_ICONS[centos]=""
#OS_ICONS[chimera]=""
OS_ICONS[debian]=""
OS_ICONS[Deepin]=""
OS_ICONS[devuan]=""
#OS_ICONS[dragonfly]=""
OS_ICONS[elementary]=""
OS_ICONS[endeavouros]=""
#OS_ICONS[eurolinux]=""
OS_ICONS[fedora]=""
OS_ICONS[freebsd]=""
OS_ICONS[gentoo]=""
#OS_ICONS[ghostbsd]=""
OS_ICONS[kali]=""
OS_ICONS[illumos]=""
OS_ICONS[linuxmint]="󰣭"
OS_ICONS[mageia]=""
OS_ICONS[manjaro]=""
OS_ICONS[nixos]=""
#OS_ICONS[ol]="󱓼"
OS_ICONS[omnios]=""
OS_ICONS[openbsd]=""
OS_ICONS[openmandriva]=""
OS_ICONS[opensuse-leap]=""
OS_ICONS[opensuse-tumbleweed]=""
OS_ICONS[openwrt]="󱂇"
OS_ICONS[pika]="󱂇"
OS_ICONS[pop]=""
OS_ICONS[raspbian]=""
OS_ICONS[rhel]=""
OS_ICONS[rocky]=""
#OS_ICONS[scientific]=""
OS_ICONS[slackware]=""
OS_ICONS[sled]=""
OS_ICONS[sles]=""
OS_ICONS[solaris]=""
OS_ICONS[steamos]=""
OS_ICONS[Ubuntu]=""
OS_ICONS[void]=""
#OS_ICONS[xenenterprise]=""


export PROMPT_OS_ICON=🔆
if [[ -e /etc/os-release ]]
then
	source /etc/os-release
	if [[ "${OS_ICONS[${ID}]}" != "" ]]
	then
		export PROMPT_OS_ICON=${OS_ICONS[${ID}]}
	elif [[ "${OS_ICONS[${ID_LIKE}]}" != "" ]]
	then
		export PROMPT_OS_ICON=${OS_ICONS[${ID_LIKE}]}
	else
		# not one of the OS or distrobutions we specifically know about, 
		# check if it's some other sort of linux
		if (( $+commands[uname] ))
		then
			$(uname -a | grep -q -i linux)
			if [[ $? -eq 0 ]]
			then
				# it's some other linux distro
				export PROMPT_OS_ICON=""
			else
				# it's not a linux distro
				$(uname -a | grep -q -i bsd)
				if [[ $? -eq 0 ]]
				then
					# it's one of the other BSDs (besides Free and Open)
					#export PROMPT_OS_ICON=""
					export PROMPT_OS_ICON="${FXP[bold]}BSD${FXP[reset]}"
				fi
			fi
		fi
	fi
fi

## DONE WITH PROMPT OS ICONS


setopt prompt_subst
setopt extended_glob
setopt PROMPT_BANG

##*********************************************
##*********************************************
