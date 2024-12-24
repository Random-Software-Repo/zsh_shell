#!/usr/bin/zsh


function command_not_found_handler
{
	## RAW_COMMAND_LINE was to be used in a calculator function, but it'll never work as well as I'd like
	## as use of / or () in the command line will error out before command_not_found is called. boo hoo.
	##local val=err
	##(( val=${RAW_COMMAND_LINE} )) >& /dev/null
	##if [[ $? -eq 0 ]]
	##then
	##	echo $val
	##else

		echo "Command not found: \"${1}\""
	##fi
}
