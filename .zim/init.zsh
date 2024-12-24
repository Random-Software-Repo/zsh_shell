zimfw() { source /home/jack/.shells/.zim/zimfw.zsh "${@}" }
zmodule() { source /home/jack/.shells/.zim/zimfw.zsh "${@}" }
fpath=(/home/jack/Development/working/shells/.zim/modules/git/functions /home/jack/Development/working/shells/.zim/modules/utility/functions /home/jack/Development/working/shells/.zim/modules/duration-info/functions /home/jack/Development/working/shells/.zim/modules/git-info/functions ${fpath})
autoload -Uz -- git-alias-lookup git-branch-current git-branch-delete-interactive git-branch-remote-tracking git-dir git-ignore-add git-root git-stash-clear-interactive git-stash-recover git-submodule-move git-submodule-remove mkcd mkpw duration-info-precmd duration-info-preexec coalesce git-action git-info
source /home/jack/Development/working/shells/.zim/modules/environment/init.zsh
source /home/jack/Development/working/shells/.zim/modules/git/init.zsh
source /home/jack/Development/working/shells/.zim/modules/input/init.zsh
source /home/jack/Development/working/shells/.zim/modules/termtitle/init.zsh
source /home/jack/Development/working/shells/.zim/modules/utility/init.zsh
source /home/jack/Development/working/shells/.zim/modules/duration-info/init.zsh
source /home/jack/Development/working/shells/.zim/modules/zsh-completions/zsh-completions.plugin.zsh
source /home/jack/Development/working/shells/.zim/modules/completion/init.zsh
source /home/jack/Development/working/shells/.zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/jack/Development/working/shells/.zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/jack/Development/working/shells/.zim/modules/zsh-history-substring-search/zsh-history-substring-search.zsh
