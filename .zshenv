#**************************************************************
#	ZSH startup file load order
#	(NOTE: ~/.profile will be loaded if ~/.zshrc is not present
#
#╔═════════════════════════╦══════════════╦══════════════╦════════╗
#║                         ║ Interactive  ║ Interactive  ║ Script ║
#║                         ║ login        ║ non-login    ║        ║
#╠═════════════════════════╬══════════════╬══════════════╬════════╣
#║ /etc/zshenv             ║     1        ║     1        ║   1    ║
#╠═════════════════════════╬══════════════╬══════════════╬════════╣
#║ ~/.zshenv               ║     2        ║     2        ║   2    ║
#╠═════════════════════════╬══════════════╬══════════════╬════════╣
#║ /etc/zprofile           ║     3        ║              ║        ║
#╠═════════════════════════╬══════════════╬══════════════╬════════╣
#║ ~/.zprofile             ║     4        ║              ║        ║
#╠═════════════════════════╬══════════════╬══════════════╬════════╣
#║ /etc/zshrc              ║     5        ║     3        ║        ║
#╠═════════════════════════╬══════════════╬══════════════╬════════╣
#║ ~/.zshrc OR ~/.profile  ║     6        ║     4        ║        ║
#╠═════════════════════════╬══════════════╬══════════════╬════════╣
#║ /etc/zlogin             ║     7        ║              ║        ║
#╠═════════════════════════╬══════════════╬══════════════╬════════╣
#║ ~/.zlogin               ║     8        ║              ║        ║
#╚═════════════════════════╩══════════════╩══════════════╩════════╝
#
#
#	ZSH exit file load order
#
#╔═════════════════════════╦══════════════╦══════════════╦════════╗
#║ ~/.zlogout              ║     9        ║              ║        ║
#╠═════════════════════════╬══════════════╬══════════════╬════════╣
#║ /etc/zlogout            ║     10       ║              ║        ║
#╚═════════════════════════╩══════════════╩══════════════╩════════╝
#**************************************************************

export HOSTNAME=$(hostname -s)
export ZDOTDIR="${HOME}/.shells"
export DBHISTMODIFIER=
if [[ -e "${ZDOTDIR}/.zshenv.${USER}" ]]
then
	## load user specific environment settings
	source "${ZDOTDIR}/.zshenv.${USER}"
fi
#
# Start configuration added by Zim install {{{
#
# User configuration sourced by all invocations of the shell
#
#echo '2 ~/.zshenv'
# Define Zim location
: ${ZIM_HOME=${HOME}/.shells/.zim}
# }}} End configuration added by Zim install

# set PATH so it includes user's private ~/.local/bin if it exists
if [ -d "${HOME}/.local/bin" ]
then
	PATH="${HOME}/.local/bin:${PATH}"
fi
# set PATH so it includes user's private ~/bin if it exists
if [ -d "${HOME}/bin" ]
then
	PATH="${HOME}/bin:${PATH}"
fi

# set PATH so it includes global /usr/games if it exists
if [ -d "/usr/games" ]
then
	PATH="${PATH}:/usr/games"
fi
