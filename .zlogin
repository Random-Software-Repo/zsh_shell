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
#
#echo '8 ~/.zlogin'

# Start configuration added by Zim install {{{
#
# User configuration sourced by login shells
#

# Initialize Zim
source ${ZIM_HOME}/login_init.zsh -q &!
# }}} End configuration added by Zim install
if (( $+commands[motd] ))
then
	motd -short
fi