#!/usr/bin/zsh
source ~/.shells/zb.prompt.common.zsh
# .zshrc
##*********************************************
##*********************************************
##
##	Prompt
##
##

## not using auto colors as we'll be using our own color arrays.
## in fact, we'll be using a 256 color color array and we'll
## pre-wrap prompt colors with %{ and %} so the prompt will
## display correctly
##autoload colors
##colors
unsetopt PROMPT_BANG
# array of colors to represent time where the colors are all 
# brown/yellows and get darker as the day progresses.
typeset -gA ZB_C_DT
ZB_C_DT=( 0 $FGP[94] 1 $FGP[94] 2 $FGP[130] 3 $FGP[130] 4 $FGP[172] 5 $FGP[172] 
			6 $FGP[226] 7 $FGP[226] 8 $FGP[227] 9 $FGP[227] 10 $FGP[228] 11 $FGP[228] 
			12 $FGP[229] 13 $FGP[229] 14 $FGP[228] 15 $FGP[228] 16 $FGP[227] 17 $FGP[227] 
			18 $FGP[226] 19 $FGP[226] 20 $FGP[172] 21 $FGP[172] 22 $FGP[130] 23 $FGP[130] )

# Box drawing glyphs 
#Set ZB_PR_OPT to the index of the group you wish to see
#This can be changed at run-time (export ZB_PR_OPT=3, e.g.)
#
#	ZB_PR_UL	upper left corner
#	ZB_PR_LL	lower left corner
#	ZB_PR_UR	upper right corner
#	ZB_PR_LR	lower right corner
#	ZB_PR_SEG	line segment
#	ZB_PR_OB	opening bracket
#	ZB_PR_CB	closing bracket

# Depending on the font used and your terminal emulator, these
# box drawing decorations may look different than here.
# 1 Light Box       ┌─{}─┐└─{}─┘
# 2 Heavy Box       ┏━┫┣━┓┗━┫┣━┛
# 3 Curved box      ╭─⧼⧽─╮╰─⧼⧽─╯
# 3 Alt. Curved box ╭─🮤🮥─╮╰─🮤🮥─╯
# 5 Heavy Arrow box ┏━►◄━┓┗━►◄━┛ (the alignment of these depends heavily on terminal and font)
# 6+ Experimental
##			 1		 2		 3		 4		 5		 6		 7		 8		 9		 10		 11		 12		 13
ZB_PR_UL_A=("┌"		"┏"		"╭"		"╭"		"┏"		"█"		"█"		"█"		"█"		"╭"		"╭"		"🭽"		"╭")
ZB_PR_LL_A=("└"		"┗"		"╰"		"╰"		"┗"		"█"		"█"		"█"		"█"		"╰"		"╰"		"🭼"		"╰")
ZB_PR_UR_A=("┐"		"┓"		"╮"		"╮"		"┓"		"█"		"█"		"█"		"█"		"╮"		"╮"		"🭾"		"╮")
ZB_PR_LR_A=("┘"		"┛"		"╯"		"╯"		"┛"		"█"		"█"		"█"		"█"		"╯"		"╯"		"🭿"		"╯")
ZB_PR_SG_A=("─"		"━"		"─"		"─"		"━"		"█"		"█"		"█"		"█"		"─"		"─"		"🮀"		"─")
ZB_PR_OB_A=("{"		"󰅁"		"󰅁"		"🮤"		"►"		"🭬"		""		"🭛"		"🭀"		"❴"		"⧼"		"🮀"		"")
ZB_PR_CB_A=("}"		"󰅂"		"󰅂"		"🮥"		"◄"		"🭮"		""		"🭋"		"🭦"		"❵"		"⧼"		"🮀"		"")

export ZB_THEME=0
function zb_set_theme()
{
	case ${ZB_THEME} in
		'1' )
			export ZB_PR_OPT=13
			export ZB_BORDER_COLOR=0
			export ZB_BORDER_BACKGROUND_COLOR=
			export ZB_BACKGROUND_COLOR=0
			;;
		'2' )
			export ZB_PR_OPT=5
			export ZB_BORDER_COLOR=2
			export ZB_BORDER_BACKGROUND_COLOR=
			export ZB_BACKGROUND_COLOR=
			;;
		'0' | * )
			export ZB_PR_OPT=4
			export ZB_BORDER_COLOR=32
			export ZB_BORDER_BACKGROUND_COLOR=
			export ZB_BACKGROUND_COLOR=
			;;
	esac
}

function zb_pr_set_decorations()
{
	zb_set_theme
	if [[ $ZB_BACKGROUND_COLOR ]]
	then
		ZB_BACKGROUND=$BGP[${ZB_BACKGROUND_COLOR}]
	else
		ZB_BACKGROUND=
	fi
	if [[ $ZB_BORDER_BACKGROUND_COLOR ]]
	then
		ZB_BORDER_BACKGROUND=$BGP[${ZB_BORDER_BACKGROUND_COLOR}]
	else
		ZB_BORDER_BACKGROUND=
	fi
	ZB_PR_UL=$ZB_PR_UL_A[${ZB_PR_OPT}]
	ZB_PR_LL=$ZB_PR_LL_A[${ZB_PR_OPT}]
	ZB_PR_UR=$ZB_PR_UR_A[${ZB_PR_OPT}]
	ZB_PR_LR=$ZB_PR_LR_A[${ZB_PR_OPT}]
	ZB_PR_SEG=$ZB_PR_SG_A[${ZB_PR_OPT}]
	ZB_PR_OB=$ZB_PR_OB_A[${ZB_PR_OPT}]
	ZB_PR_CB=$ZB_PR_CB_A[${ZB_PR_OPT}]


	#Box / border color
	ZB_C_B="$FXP[reset]$ZB_BORDER_BACKGROUND$FGP[${ZB_BORDER_COLOR}]$FXP[bold]"
	#Error codes color
	ZB_C_E="$FXP[reset]$ZB_BACKGROUND$FGP[1]"
	#Executine Time Color (seconds)
	ZB_C_S="$FXP[reset]$ZB_BACKGROUND$FGP[2]"
	#Local Normal User Color
	ZB_C_LU="$FXP[reset]$ZB_BACKGROUND$FGP[2]"
	#Local Different (from logged in user) User Color
	ZB_C_DU="$FXP[reset]$ZB_BACKGROUND$FGP[208]"
	#Root User Color
	ZB_C_RU="$FXP[reset]$ZB_BACKGROUND$FGP[1]$FXP[blink]"
	#Remote (non local) User color
	ZB_C_NLU="$FXP[reset]$ZB_BACKGROUND$FGP[202]"
	#Local Host Color
	ZB_C_LH="$FXP[reset]$ZB_BACKGROUND$FGP[46]"
	#Remote Host Color
	ZB_C_RH="$FXP[reset]$ZB_BACKGROUND$FGP[99]$FXP[blink]"
	#PWD color
	ZB_C_P="$FXP[reset]$ZB_BACKGROUND$FGP[228]"
	#Plain Text Color
	ZB_C_T="$FXP[reset]$ZB_BACKGROUND$FGP[15]"
	#Git Branch Color
	ZB_C_G="$FXP[reset]$ZB_BACKGROUND$FXP[bold]$FGP[11]"


}

# Wraps a string in opening and closing brackets.
function zb_pr_wrap()
{
	echo "${ZB_C_B}${ZB_PR_OB}${ZB_C_T}${1}${ZB_C_B}${ZB_PR_CB}"
}
function zb_pr_wrap_plain()
{
	echo "${ZB_PR_OB}${1}${ZB_PR_CB}"
}
###################################################
## Prompt Segments
## Each Prompt Segment function will set two variables,
## one will be a string containing the element specified
## without any escape sequences. This is suitable to non-
## color terminals and for determing the length of the 
## segment. The other will will include all prompt-specific 
## escape sequences needed to display it's colors correctly.
##
## The two variables will be 
##		ZB_PR_<SEGMENT>_PLAIN
## and
##		ZB_PR_<SEGMENT>
## the function name will be 
##		zb_pr_<segment>
###################################################

function zb_pr_git()
{
	local git_repo=$(git branch --show-current 2>/dev/null)
	if [[ "${git_repo}" != "" ]]
	then
		ZB_PR_GIT_PLAIN="(${git_repo})"
		ZB_PR_GIT="${ZB_C_G}(${git_repo})"
	else
		ZB_PR_GIT_PLAIN=""
		ZB_PR_GIT=""
	fi
}

function zb_pr_pwd()
{
	local prefixlen=${#1}

	local max_pwd_len=$(( COLUMNS - prefixlen - 8 ))
	ZB_PR_PWD_PLAIN="${PWD}"
	if [[ ${#ZB_PR_PWD_PLAIN} -gt ${max_pwd_len} ]]
	then
		local pr_len=${#ZB_PR_PWD_PLAIN}
		local max_pwd_seg=$(( max_pwd_len - 2 ))
		local startindex=$(( pr_len - max_pwd_seg  ))
		ZB_PR_PWD_PLAIN="..${ZB_PR_PWD_PLAIN:$startindex}"
	fi

	ZB_PR_PWD="${ZB_C_P}${ZB_PR_PWD_PLAIN}"
}

function zb_pr_shell()
{
	ZB_PR_SHELL_PLAIN="${SHLVL}:${HISTCMD}"
	ZB_PR_SHELL="${ZB_C_T}${SHLVL}:${HISTCMD}"
}

function zb_pr_errorcode()
{
	ZB_PR_ERRORCODE_PLAIN="${1}"
	ZB_PR_ERRORCODE="${ZB_C_E}${1}"
}

function zb_pr_runtime()
{
	ZB_PR_RUNTIME_PLAIN="${1}s"
	ZB_PR_RUNTIME="${ZB_C_S}${1}s"
}

function zb_pr_datetime()
{
	#############
	## Determine the color to use for the time. 
	## Time is yellow (ish) to dark orange (ish), colors are defined in the
	## HOUR_COLOR array (see above) and changed approximately every two hours,
	## or whatever happens to be in the array
	local dtcolor="$ZB_C_DT[$(( $(date '+%H') % 24 ))]"
	ZB_PR_DATETIME_PLAIN="$(date +'%A, %B %_d, %Y %r')"
	ZB_PR_DATETIME="$FXP[reset]$BGP[${ZB_BACKGROUND_COLOR}]${dtcolor}${ZB_PR_DATETIME_PLAIN}"
}

function zb_pr_user()
{
	######
	# Determine who the User is, and set the color for the user appropriately
	# modified from a bash prompt by Dave Vehrs 
	# defaults to white, but that should never actually be used
	#Local Normal User Color
	#ZB_C_LU="$FXP[reset]$FGP[2]"
	#Local Different (from logged in user) User Color
	#ZB_C_DU="$FXP[reset]$FGP[208]"
	#Root User Color
	#ZB_C_RU="$FXP[reset]$FGP[1]$FXP[blink]"
	#Remote (non local) User color
	#ZB_C_NLU="$FXP[reset]$FGP[202]"
	local PROMPT_USERCOLOR="${ZB_C_LU}"
	if [[ "${UID}" == "0" ]]
	then
		# user is root, red
		PROMPT_USERCOLOR="${ZB_C_RU}"
	else
		if [[ "${USER}" == "${LOGNAME}" ]]
		then	 
			# The current logged in user is the current user. effective default
			# bright green
			PROMPT_USERCOLOR="${ZB_C_LU}"
		else		
			# orange					   
			PROMPT_USERCOLOR="${ZB_C_DU}"
		fi
	fi
	########
	# Determine the status of the host computer, and set color for host appropriately
	#Local Host Color
	#ZB_C_LH="$FXP[reset]$FGP[46]"
	#Remote Host Color
	#ZB_C_RH="$FXP[reset]$FGP[99]"

	local PROMPT_HOSTCOLOR="${ZB_C_LH}"
	if [[ "${SSH_CLIENT}" != "" ]]
	then 
		PROMPT_HOSTCOLOR="${ZB_C_RH}"
	fi
	# create the user@host:tty field
	# calculate the total length of username@host:pts/XXX as will used in the prompt so we can right-justify it.
	local userhostrawstring="${USER}@${HOSTNAME:fr}:pts/"
	local userptsnum=${TTY:t}
	ZB_PR_USER_PLAIN="${userhostrawstring}${userptsnum}"
	ZB_PR_USER="${PROMPT_USERCOLOR}${USER}${ZB_C_T}@${PROMPT_HOSTCOLOR}${HOSTNAME:fr}${ZB_C_T}:pts/${userptsnum}"
}
##
##	zb_prompt_precmd
##	This executes each time before the prompt is displayed. 
##	This precmd:
##	1) determines which color to use to display the time. The
##	time is displayed in a largely yellow-ish color which starts
##	out very bright in the wee-hours, and gets progressively
##	darker as the current time approaches midnight.
##	2) precmd also sets the right prompt using the seasonalemoji
##	command (external compiled executable)
##	3) creates the part of the prompt containing the previous
##	command's error code, execution time (whole seconds only), 
##	long format date and time (colorized)
function zb_prompt_precmd 
{
	### errorcode=$? MUST be the first line in zb_prompt_precmd 
	### or the error code of the last run command will be lost
	### and won't appear in the prompt.
	local errorcode=$?
	zb_pr_set_decorations
	zb_pr_errorcode $errorcode

	local runtime=0
	if [[ $CSTARTS ]]
	then 
		(( runtime = SECONDS - CSTARTS ))
	fi
	zb_pr_runtime ${runtime}
	zb_pr_user
	zb_pr_datetime
	zb_pr_shell
	zb_pr_git
	zb_pr_pwd ${ZB_PR_GIT_PLAIN}${ZB_PR_SHELL_PLAIN}

	# create the separator line. The separator line is no longer full screen width,
	# but now extends from the end of the time portion of the prompt to the right
	# edge of the screen.
	if [[ "$TTY" =~ "/dev/tty" ]]
	then
		PR_SEPLINE="|"
		#PR_LINESEG=ZB_PR_SEG
	else
		# prompt separator line no-control characters (PR_SEPLINE_NC) skips the control character so we can correctly
		# determine it's length to later pad the line to the end of the terminal.
		ZB_PR_LINE1_PLAIN=${(%):-${ZB_PR_UL}$(zb_pr_wrap_plain "${ZB_PR_ERRORCODE_PLAIN}")${ZB_PR_SEG}$(zb_pr_wrap_plain "${ZB_PR_RUNTIME_PLAIN}")${ZB_PR_SEG}$(zb_pr_wrap_plain "${ZB_PR_USER_PLAIN}")${ZB_PR_SEG}}
		ZB_PR_LINE1=${(%):-${ZB_C_B}${ZB_PR_UL}$(zb_pr_wrap "${ZB_PR_ERRORCODE}")${ZB_C_B}${ZB_PR_SEG}$(zb_pr_wrap "${ZB_PR_RUNTIME}")${ZB_C_B}${ZB_PR_SEG}$(zb_pr_wrap "${ZB_PR_USER}")${ZB_C_B}${ZB_PR_SEG}%F{default}}
		#PR_LINESEG=${ZB_PR_SEG}
	fi
	
	local prplen=${#ZB_PR_LINE1_PLAIN}
	local linewidth=${COLUMNS}
	local datetimelength=${#ZB_PR_DATETIME_PLAIN}
	((prplen = prplen + datetimelength +4 ))

	# pad the PR_SEPLINE to the end of the terminal (minus the user@host/pts bit)
	ZB_PR_LINE1="${ZB_PR_LINE1}${ZB_C_B}"
	while [ $linewidth -gt $prplen ]
	do
		ZB_PR_LINE1="${ZB_PR_LINE1}${ZB_PR_SEG}"
		(( linewidth=linewidth-1 ))
	done
	ZB_PR_LINE1=${ZB_PR_LINE1}$(zb_pr_wrap ${ZB_PR_DATETIME})${ZB_C_B}${ZB_PR_SEG}${ZB_PR_UR}
	



	ZB_PR_LINE2_PLAIN="${ZB_PR_LL}$(zb_pr_wrap_plain ${ZB_PR_SHELL_PLAIN})${ZB_PR_SEG}$(zb_pr_wrap_plain ${ZB_PR_GIT_PLAIN}${ZB_PR_PWD_PLAIN})${ZB_PR_SEG}${ZB_PR_LR}"
	local line2length=${#ZB_PR_LINE2_PLAIN}
	local line2padlength=$(( COLUMNS-line2length ))
	local line2pad=${ZB_PR_SEG}
	while (( line2padlength > 0 ))
	do
		line2pad="${line2pad}${ZB_PR_SEG}"
		(( line2padlength = line2padlength - 1 ))
	done
	ZB_PR_LINE2="${ZB_C_B}${ZB_PR_LL}$(zb_pr_wrap ${ZB_PR_SHELL})${ZB_C_B}${ZB_PR_SEG}$(zb_pr_wrap ${ZB_PR_GIT}${ZB_PR_PWD})${ZB_C_B}${line2pad}${ZB_PR_LR}"

	##	RPROMPT is the right prompt. This is displayed at the right edge of the terminal.
	##	Setting an RPROMPT might be useful as a visual indicator whether a previous command
	##	has completed or not. (e.g. If there is no right prompt, then it hasn't). This is likely
	##	only useful if a terminal window is partially obscured making the standard 
	##	prompt difficult to see. Also it's kinda cool. Most of these examples depend on
	##	full unicode and diacritical support in your terminal, which is not yet ubiquitious.
	#RPROMPT=';-)'
	#RPROMPT='ಠ_ಠ '
	#RPROMPT='ᔑ•ﺪ͟͠•ᔐ'
	#RPROMPT='(͡°͜ʖ͡°)'
	RPROMPT='🔱 '
	#RPROMPT='✨'
	# seasonalemoji can return multiple possible emojis
	if (( $+commands[seasonalemoji] )) 
	then
		RPROMPT="$(seasonalemoji )"
	fi
	export CSTARTS=

}

function zb_prompt_preexec () 
{
	export CSTARTS=$SECONDS
#	local CMD=${1[(wr)^(*=*|sudo|-*)]}
#	echo -n "\ek$CMD\e\\"
}

function zb_setprompt () 
{
	#PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
	#PR_TITLEBAR=$'${1[(wr)^(*=*|sudo|-*)]}'


	###
	###  Finally, the prompt.
	###  the $((${SECONDS}-(${CSTARTS}+0))) shows the execution time of the previous
	###  command in seconds. $CSTARTS is set in preexec() and the zsh/mathfunc must
	###  be loaded for this to work. Also, the +0 bit ensures we have a number in
	###  CSTARTS on first execution (seems there isn't a number there on the first
	###  display.
	if [[ "$TTY" =~ "/dev/tty" ]]
	then
		# running in a tty console, so  most extra features won't work. 
		# use a basic prompt instead
		PROMPT='${ZB_PR_LINE1_PLAIN}
|-<%?,$((${SECONDS}-(${CSTARTS}+0)))s>---<%D{%A, %B %f, %Y} %D{%r}>-----------------
|-<%d/>-|
|-<%L:%!>-<%n@%m:%l>->> '

		RPROMPT=''
	else
		# running in s pseudo tty (probably a grpaphical or ssh terminal),
		# so extra features will work. Have at it...

		#Several options for the left most part of the prompt immediately prior to the cursor:
		L00="💲$FXP[reset]"
		L01="🔅$FXP[reset]"
		L02="🔆 💲$FXP[reset]"
		L03="🔆$FGP[34] ❱❱ $FXP[reset]"
		L04="🔆$FGP[34] ⫸ $FXP[reset]"
		L05="${PROMPT_OS_ICON}$FGP[34] ❱❱ $FXP[reset]"

		#The actual, whole prompt (insert your chosen option in the last line ofthe prompt:
		PROMPT='${(e)PR_TITLEBAR}%B${ZB_PR_LINE1}$FXP[reset]
${ZB_PR_LINE2}$FXP[reset]
${L05}'
	fi

	PS2='$FGP[6]━$FGP[4]━($FGP[10]%_$FGP[4]━$FGP[6]━%F{default} '

	export CSTARTS=$SECONDS
}

zb_setprompt

##*********************************************
##*********************************************
