source "$ZDOTDIR"/.zshenv
source "$ZDOTDIR"/.zprofile

source "$PREFIX"/etc/profile.d/texlive.sh

autoload -Uz compinit promptinit
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
promptinit

bindkey -v

# Add text object extension -- eg ci" da(:
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M "$m" "$c" select-quoted
    done
done

setopt autocd
setopt autolist
setopt interactivecomments
setopt promptsubst

HISTSIZE=100000
SAVEHIST=100000

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
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' rehash true

source "$ZPLUGINS"/zsh-syntax-highlighting/catppuccin_mocha-zsh-syntax-highlighting.zsh
source "$ZPLUGINS"/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source "$ZPLUGINS"/zsh-autopair/autopair.zsh
source "$ZPLUGINS"/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source "$ZPLUGINS"/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh

eval "$(navi widget zsh)"
eval "$(register-python-argcomplete pipx)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"