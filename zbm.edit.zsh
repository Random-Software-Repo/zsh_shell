#!/usr/bin/zsh

##*********************************************
##*********************************************
##
##	ZSH function to open an editor with some 
##	understanting of which editors are installed,
##	and whether or not an X11 or Wayland desktop 
##	is running.
##
##*********************************************
##*********************************************
#
#
## Define a list of preferred editors for each environment: graphical (GUI) and text (TUI/console)
## Each editor should be the full path to the executable. The first one found will be executed.
## If no suitable editor is found, and error message will be displayed.
##
## In a GUI environment, the TUI editors will be tried *after* all GUI editors have been checked and
## found to be missing.

export GUIEDITORS=( $(command which subl) $(command which xed) $(command which geany) $(command which nvim) $(command which gedit) $(command which kate))
export TUIEDITORS=($(command which nvim) $(command which vim) $(command which vi) $(command which nano) $(command which pico) )

function edit
{
	## check whether we're in an x/wayland session
	## if we are, run a GUI editor,if not, tui editor
	local -a EDITORS 
	local command=
	if [[ "$XDG_SESSION_TYPE" =~ "(x11|wayland)" ]]
	then
		## gui
		EDITORS=(${GUIEDITORS} ${TUIEDITORS})
	else
		## tui
		EDITORS=(${TUIEDITORS})
	fi

	for e in ${EDITORS} 
	do
		#echo $e
		if [[ -e "${e}" ]]
		then
			command="${e}"
			break
		fi
	done

	if [[ -n "${command}" ]]
	then
		"${command}" "$@"
	else
		echo "No editor found: ${EDITORS}"
		exit -1
	fi
}