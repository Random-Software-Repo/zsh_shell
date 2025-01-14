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
typeset -Ag FX FG BG FGP BGP FXP POSICONS

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
## HAVE A /etc/os-release FIlE WITH A "KNOWN" ID= VALUE)
## EVEN SO, NOT ALL OF THESE HAVE NERD-FONT ICONS
POSICONS[linux]=""
POSICONS[almalinux]=""
POSICONS[alpine]=""
POSICONS[arch]=""
POSICONS[centos]=""
POSICONS[chimera]=""
POSICONS[debian]=""
POSICONS[Deepin]=""
POSICONS[dragonfly]=""
POSICONS[elementary]=""
POSICONS[endeavouros]=""
POSICONS[eurolinux]=""
POSICONS[fedora]=""
POSICONS[freebsd]=""
POSICONS[gentoo]=""
POSICONS[ghostbsd]=""
POSICONS[illumos]=""
POSICONS[linuxmint]="󰣭"
POSICONS[manjaro]=""
POSICONS[nixos]=""
POSICONS[ol]=""
POSICONS[omnios]=""
POSICONS[openbsd]=""
POSICONS[openmandriva]=""
POSICONS[opensuse-leap]=""
POSICONS[opensuse-tumbleweed]=""
POSICONS[openwrt]="󱂇"
POSICONS[pika]="󱂇"
POSICONS[pop]=""
POSICONS[raspbian]=""
POSICONS[rhel]=""
POSICONS[rocky]=""
POSICONS[slackware]=""
POSICONS[sles]=""
POSICONS[solaris]=""
POSICONS[steamos]=""
POSICONS[Ubuntu]=""
POSICONS[void]=""


source /etc/os-release
export PROMPT_OS_ICON=${POS[${ID}]}
## DONE WITH PROMPT OS ICONS


setopt prompt_subst
setopt extended_glob
setopt PROMPT_BANG

##*********************************************
##*********************************************
