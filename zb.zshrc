#!/usr/bin/zsh

umask 077
ulimit -c 0
unset MAILCHECK
setopt auto_list
setopt numeric_glob_sort
setopt no_sh_word_split
setopt auto_pushd
setopt pushd_ignore_dups
setopt nohup
## History command configuration
setopt extended_history			# record timestamp of command in HISTFILE
#setopt hist_expire_dups_first	# delete duplicates first when HISTFILE size exceeds HISTSIZE
#setopt hist_ignore_dups			# ignore duplicated commands history list
#setopt hist_save_no_dups		# remove duplicates when saving history
setopt hist_ignore_space		# ignore commands that start with space
setopt hist_verify				# show command with history expansion to user before running it
setopt INC_APPEND_HISTORY_TIME	# append to history file immediately (rather than on shell exit) and include execution time
#setopt share_history			# share command history data
setopt append_history			# append to history file (rather than overwrite)
export HISTFILE=~/.zsh_history${DBHISTMODIFIER}	# location of saved history file
export HISTSIZE=100000			# number of history lines in memory
export SAVEHIST=10000000		# number of history lines saved in HISTFILE
export DIRSTACKSIZE=100


zmodload -i zsh/complete
zmodload -i zsh/compctl 
zmodload -i zsh/computil
zmodload -i zsh/complist 
zmodload -i zsh/curses
zmodload -i zsh/datetime 
#zmodload -i zsh/files
zmodload -i zsh/mapfile
zmodload -i zsh/mathfunc
zmodload -i zsh/parameter 
zmodload -i zsh/regex
zmodload -i zsh/sched 
zmodload -i zsh/stat 
zmodload -i zsh/zprof 



# Cycle through history based on characters already typed on the line
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search

source ~/.shells/zb.environment.zsh
source ~/.shells/zb.aliases.zsh
source ~/.shells/zb.prompt.zsh
#source ~/.shells/zb.history.zsh

autoload -U add-zsh-hook

add-zsh-hook precmd zb_prompt_precmd
#add-zsh-hook preexec zb_preexec
add-zsh-hook preexec zb_prompt_preexec

# load all zb modules
for zbmodule in ~/.shells/zbm.*(N)
do
	source ${zbmodule}
done

# load any user specific zb modules
for userfile in ~/.shells/zb.${USER}.*(N)
do
	source ${userfile}
done

