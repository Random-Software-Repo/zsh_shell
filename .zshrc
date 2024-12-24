###zmodload zsh/zprof 
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
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v
# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------
# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
	# Declare the variable
	typeset -A ZSH_HIGHLIGHT_STYLES
	# To differentiate aliases from other command types
	#ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
	# To have paths colored instead of underlined
	ZSH_HIGHLIGHT_STYLES[path]='fg=yellow,bold'
	# To disable highlighting of globbing expressions
	#ZSH_HIGHLIGHT_STYLES[globbing]='none'
# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
	# Download zimfw script if missing.
### This is potentially pretty dangerous. Probably shouldn't do this 
### (download from the wild internet, that is)
#	command mkdir -p ${ZIM_HOME}
#	if (( ${+commands[curl]} ))
#	then
#		command curl -fsSL -o ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
#	else
#		command wget -nv -O ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
#	fi
fi
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]
then
	# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
	source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]
then
	bindkey ${terminfo[kcuu1]} history-substring-search-up
	bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# }}} End configuration added by Zim install

export ZIM_HOME=~/.shells/.zim

# Customize to your needs...
unset MAILCHECK
setopt append_history
setopt auto_list
setopt numeric_glob_sort
setopt no_sh_word_split
#setopt vi
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_dups
setopt nohup
setopt CASE_GLOB




source "${ZDOTDIR}/zb.zshrc"

#Sourcing DBHIST, if it exists.
if [[ -e "${ZDOTDIR}/dbhist.zsh" ]]
then
	source "${ZDOTDIR}/dbhist.zsh"
fi
