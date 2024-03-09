source "$ZDOTDIR"/.zshenv
source "$ZDOTDIR"/.zprofile

autoload -Uz compinit promptinit
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
promptinit

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

source "$ZPLUGINS"/fzf-tab/fzf-tab.plugin.zsh

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache true

source "$ZPLUGINS"/zsh-syntax-highlighting/catppuccin_mocha-zsh-syntax-highlighting.zsh
source "$ZPLUGINS"/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source "$ZPLUGINS"/zsh-autopair/autopair.zsh
source "$ZPLUGINS"/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source "$ZPLUGINS"/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh

source "$PREFIX"/etc/profile.d/texlive.sh

eval "$(navi widget zsh)"
eval "$(register-python-argcomplete pipx)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"