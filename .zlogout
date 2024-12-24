#!/usr/bin/zsh
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

if [[ -n "$SSH_CLIENT" ]]
then
	if (( $+commands[calvin] ))
	then
		calvin -s 0.01 0
		sleep 0.5
	fi
fi