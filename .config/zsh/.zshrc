source "$ZDOTDIR"/.zshenv
source "$ZDOTDIR"/.zprofile

autoload -Uz compinit promptinit
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
promptinit

source /data/data/com.termux/files/usr/etc/profile.d/texlive.sh

setopt auto_cd
setopt auto_list
setopt interactive_comments
setopt prompt_subst

HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt share_history

source "$HOME"/.shplugins/fzf-tab/fzf-tab.plugin.zsh

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' rehash true

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

source "$HOME"/.shplugins/zsh-syntax-highlighting/catppuccin_mocha-zsh-syntax-highlighting.zsh
source "$HOME"/.shplugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source "$HOME"/.shplugins/zsh-autopair/autopair.zsh
source "$HOME"/.shplugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source "$HOME"/.shplugins/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh

eval "$(navi widget zsh)"
eval "$(register-python-argcomplete pipx)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"