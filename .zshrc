export PATH=/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/share/texlive/bin/aarch64-linux:"$HOME"/.local/share/cargo/bin:"$HOME"/.local/share/go/bin:"$HOME"/.local/share/ltex-ls/bin:"$HOME"/.local/share/npm/bin:"$HOME"/.local/share/pipx/bin

export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_RUNTIME_DIR=/run/user/"$UID"
export XDG_STATE_HOME="$HOME"/.local/state

autoload -Uz compinit promptinit
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
promptinit

export EDITOR=nvim
export LANG=en_US.UTF-8
export VISUAL=nvim
# necessary for starship on android
export USER=darumyro

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PIPX_BIN_DIR="$XDG_DATA_HOME"/pipx/bin
export PIPX_MAN_DIR=/data/data/com.termux/files/usr/share/man
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/ripgrep/config
export SQLITE_HISTORY="$XDG_DATA_HOME"/sqlite_history
export STARSHIP_CACHE="$XDG_CACHE_HOME"/starship
export STARSHIP_CONFIG="$XDG_CONFIG_HOME"/starship/config.toml
export TEXMFCONFIG="$XDG_CONFIG_HOME"/texlive/texmf-config
export TEXMFHOME="$XDG_DATA_HOME"/texmf
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var
export W3M_DIR="$XDG_STATE_HOME"/w3m
export WEGORC="$XDG_CONFIG_HOME"/wego/wegorc
export WGETRC="$XDG_CONFIG_HOME"/wgetrc

export EZA_ICONS_AUTO=always

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--ansi --cycle --inline-info --layout=reverse --preview-window=wrap"

# global pager
export PAGER="nvim +Man!"

export RCLONE_BUFFER_SIZE=512Mi
export RCLONE_CHECK_FIRST=TRUE
export RCLONE_CHECKSUM=TRUE
export RCLONE_COPY_LINKS=TRUE
export RCLONE_CREATE_EMPTY_SRC_DIRS=TRUE
export RCLONE_FAST_LIST=TRUE
export RCLONE_HUMAN_READABLE=TRUE
export RCLONE_METADATA=TRUE
export RCLONE_TRANSFERS=5
export RCLONE_PROGRESS=TRUE

export TAPLO_CONFIG="$HOME"/.taplo.toml

export YAMLFIX_WHITELINES=1
export YAMLFIX_INDENT_MAPPING=4
export YAMLFIX_INDENT_OFFSET=4
export YAMLFIX_QUOTE_REPRESENTATION='"'

export ZSH_AUTOSUGGEST_STRATEGY=(completion history)

source "$XDG_CONFIG_HOME"/zsh/functions.sh
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
