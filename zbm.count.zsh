#!/usr/bin/zsh

##*********************************************
##*********************************************
##
##	ZSH count 
##	counts things. any things. all things.
##
##*********************************************
##*********************************************
#
#
function count
{
	if [[ "$#" == "0" ]]
	then
		echo "Usage:"
		echo "	count <file list or other list of parameters>"
		echo "Count will print out the number of items passed in."
		echo "Examples:"
		echo "	count all files in the current directory:"
		echo "		count *"
		echo "	count all directories in the current directory including subdirectories:"
		echo "		count **/*(/)"
		echo "	count how many users are currently logged in:"
		echo "		count \$(users)"
		echo "	count how many groups the current user is in:"
		echo "		count \$(groups)"
	else
		echo $#
		#original one line non-function version of this
		#ccc=0;for d in "$@";do (( ccc++ )); done; echo $ccc;
	fi
}
alias countfiles=count
alias cf=count
##*********************************************
##*********************************************
##
##	END OF ZBM.COUNT
##
##*********************************************
##*********************************************
