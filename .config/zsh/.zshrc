source "$ZDOTDIR"/.zshenv
source "$ZDOTDIR"/.zprofile

autoload -Uz compinit promptinit
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
promptinit

source /data/data/com.termux/files/usr/etc/profile.d/texlive.sh

setopt autocd
setopt autolist
setopt interactivecomments
setopt promptsubst

HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory
setopt extendedhistory
setopt histexpiredupsfirst
setopt histfindnodups
setopt histignorealldups
setopt histignoredups
setopt histignorespace
setopt histreduceblanks
setopt histsavenodups
setopt histverify
setopt incappendhistory
setopt sharehistory

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