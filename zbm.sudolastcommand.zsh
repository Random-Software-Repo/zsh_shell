#!/usr/bin/zsh

##*********************************************
##*********************************************
##
##	repeats last command with sudo
##
##*********************************************
##*********************************************

add-zsh-hook zshaddhistory zb_zshaddhistory

if [[ ! -v ZB_LASTCOMMAND ]]
then
	typeset ZB_LASTCOMMAND
fi

function zb_zshaddhistory
{
	#if [[ ! "${1}" =~ '^sudo ' && ! "${1}" =~ '^fuck ' && ! "${1}" =~ '^please ' && "${1}" != "su" && "${1}" != "sudo"  && "${1}" != "please"  && "${1}" != "fuck" ]]
	if [[ ! "${1}" =~ '(^sudo|^fuck|^please|^su$|^sudo$|^fuck$|^please$)' ]]
	then
		## only update the last command if is wasn't something run with sudo/fuck/please
		#echo "updating ZB_LASTCOMMAND=${1}"
		ZB_LASTCOMMAND=${1}
	fi
}

alias please=fuck
function fuck
{
	##	Fuck: what I meant to do....
	##	Repeats the previous command with sudo. If the environment variable SUDOVERBOSE
	##	is set, the command line (with sudo) to be run will also be echoed to STDOUT.
	##
	##	The previous command is stored in ZB_LASTCOMMAND
	##	The history is not used as any command-line parameters with spaces quoted will
	##	be interpreted as multiple discrete parameters rather than single parameters.
	##	The horrendous loop and case structure below processes the previous command 
	##	line as a whole and *mostly* handles quotes and escapes (the \ character)
	##	somewhat correctly. It does not handle new lines embeded in a single command 
	##	line. It does not handle variable expansion, either. It, currently, doesn't
	##	handle quotes embeded in quotes. It does handle either type of quote, but not
	##	both together.
	##
	##	What the command *should* look like if history didn't blow away quoted/escaped
	##	parameters like a fart in the wind:
	##
	##	sudo $(fc -lIn -1 )
	##
	local index=1
	local p=$ZB_LASTCOMMAND
	local len=${#p}
	local current=
	local inquotes=
	local inescape=
	local command=
	local -a commandoptions

	## for loop. loop over last command up to, but not including the last character,
	## which will be a new line (see zshaddhistory in 'man zshmisc') which we don't
	## want, and which case statements don't seem to be able to select on, or at
	## least I haven't found an string that will match a newline (tried "\n", '\n',
	## just \n by itself, [:space:] (didn't really expect that to work)).
	for ((index=0 ; index < (len-1) ; index++ ))
	do
		c=${p:$index:1}
		#print $c
		case "${c}" in
			("\\")
				#echo "slash"
				if [[ -n $inescape ]]
				then
					inescape=
					current="${current}${c}"
				else
					inescape=yes
				fi
				;;
			(" "|"	"|"\n")
				if [[ "${c}" == "\n" ]]
				then
					# this code is never reached.
					#echo "new line"
				fi
				if [[ -n $inquotes || -n $inescape ]]
				then
					#echo "quoted white space"
					#echo "inquotes=\"${inquotes}\" || inescape=\"${inescape}\""
					# if the space/ta
					current="${current}${c}"
					inescape=
				else
					#echo "white space"
					#echo "! inquotes=\"${inquotes}\" && inescape=\"${inescape}\""
					if [[ -n "$current" ]]
					then
						#echo "  current=\"${current}\""
						if [[ ! -n "${command}" ]]
						then
							command="${current}"
						else
							commandoptions+=("${current}")
						fi
						current=
					fi
				fi
				;;
			("\"")
				#echo "quote"
				if [[ -n $inquotes ]]
				then
					if [[ -n $inescape ]]
					then
						current="${current}${c}"
						inescape=
					else
						#echo "  current=\"${current}\""
						inquotes=
						if [[ ! -n "${command}" ]]
						then
							command="${current}"
						else
							commandoptions+=("${current}")
						fi
						current=
					fi
				else
					inquotes=yes
				fi
				;;
			(*)
				#echo -n "'$c' "
				current="${current}${c}"
				;;
		esac
		#echo $c
	done
	if [[ -n "$current" ]]
	then
		#echo "  current=\"${current}\""
		if [[ ! -n "${command}" ]]
		then
			command="${current}"
		else
			commandoptions+=("${current}")
		fi
		current=
	fi
	#for o in ${commandoptions}
	#do
	#	echo "option= \"${o}\""
	#done
	if [[ -n "$SUDOVERBOSE" ]]
	then
		echo "sudo ${command} ${commandoptions}" 
	fi
	sudo ${command} ${commandoptions}
}

##*********************************************
##*********************************************
##
##	END OF ZBM.SUDOLASTCOMMAND
##
##*********************************************
##*********************************************
