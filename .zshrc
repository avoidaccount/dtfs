autoload -Uz compinit promptinit
compinit -d "~/.cache/zsh/zcompdump-$ZSH_VERSION"
promptinit

export EDITOR=nvim
export VISUAL=nvim

export LANG=en_US.UTF-8
export USER=darumyro

export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_RUNTIME_DIR=/run/user/$UID
export XDG_STATE_HOME="$HOME"/.local/state

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/ripgrep/config
export SQLITE_HISTORY="$XDG_DATA_HOME"/sqlite_history
export STARSHIP_CONFIG="$XDG_CONFIG_HOME"/starship/config.toml
export WEGORC="$XDG_CONFIG_HOME"/wego/wegorc
export WGETRC="$XDG_CONFIG_HOME"/wgetrc

export EZA_ICONS_AUTO=always

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow"
export FZF_DEFAULT_OPTS="--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --ansi --cycle --exact --inline-info --layout=reverse --preview-window=wrap"

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
export RCLONE_VERBOSE=1

function _dotfiles() {
	git --git-dir="$HOME"/dtf/ --work-tree="$HOME"
}

function dotfiles() {
	gitui --directory "$HOME"/.dtf/ --workdir "$HOME" "$@"
}

function cop() {
	cp --interactive --recursive --verbose "$@"
}

function mdi() {
	mkdir --parents --verbose "$@"
}

function mov() {
	mv --interactive --verbose "$@"
}

function rem() {
	rm --force --recursive --verbose "$@"
}

function l() {
	eza --all --group-directories-first --hyperlink --long --no-quotes --sort=extension
}

function ls() {
	eza --all --group-directories-first --hyperlink --no-quotes --sort=extension
}

function lt() {
	eza --all --group-directories-first --hyperlink --level 2 --no-quotes --sort=extension --tree
}

function gdl() {
	gallery-dl --config-yaml "$XDG_CONFIG_HOME/gallery-dl/config.yaml" "$@"
}

function zarchive() {
	7zz a -mx=0 "$@"
}

function zxtract() {
	7zz x -y "$@"
}

function autodl-with-gdl() {
	gdl --input-file "$XDG_CONFIG_HOME/.utils/gallery-dl/paywall-updates.py" &&
	gdl --input-file "$XDG_CONFIG_HOME/.utils/gallery-dl/pixiv-updates.txt" &&
	find "/storage/emulated/0/gdl" -type d -empty -delete -print
}

function rust-bin-to-path() {
	mv "$XDG_DATA_HOME/cargo/bin/*" "$PATH"
}

function delete-empty-dirs() {
	find "$@" -type d -empty -delete -print
}

function find-broken-symlinks() {
	find "$@" -type l ! -exec test -e {} \; -print
}

function gdrive-file-download() {
	gdown --fuzzy --output "/storage/emulated/0/Download" "$@"
}

function gdrive-folder-download() {
	gdown --folder --output "/storage/emulated/0/Download" "$@"
}

function install-gdl-dev() {
	python3 -m pip install -U -I --no-deps --no-cache-dir "https://github.com/mikf/gallery-dl/archive/master.tar.gz"
}

function batch-rename-pattern() {
	rnr --force --no-dump --recursive --replace-limit=0 "$@"
}

function sync-with-proton() {
	rclone sync "$XDG_CONFIG_HOME/.utils/gallery-dl" "proton:dotdroid/.utils/gallery-dl" &&
	rclone sync "$XDG_CONFIG_HOME/beets/library.db" "proton:dotdroid/beets" &&
	rclone sync "$XDG_CONFIG_HOME/beets/state.pickle" "proton:dotdroid/beets" &&
	rclone sync "$XDG_CONFIG_HOME/fd" "proton:dotdroid/fd" &&
	rclone sync "$XDG_CONFIG_HOME/gallery-dl" "proton:dotdroid/gallery-dl" &&
	rclone sync "$XDG_CONFIG_HOME/git" "proton:dotdroid/git" &&
	rclone sync "$XDG_CONFIG_HOME/qobuz-dl" "proton:dotdroid/qobuz-dl" &&
	rclone sync "/storage/emulated/0/wikimyro" "proton:wikimyro" &&
	rclone sync "/storage/emulated/0/tcc" "proton:archive/tcc"
}

function swap-dashes-with-spaces() {
	rnr --force --no-dump --recursive --replace-limit=0 "-" " " "$@"
}

function wiki() {
	cd "/storage/emulated/0/wikimyro" && vi
}

setopt auto_cd
setopt auto_list
setopt interactive_comments
setopt prompt_subst

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

HISTSIZE=1000
SAVEHIST=1000

source ~/.shplugins/fzf-tab/fzf-tab.plugin.zsh

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

zstyle ':completion:*' cache-path "~/.cache/zsh/zcompcache"

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' rehash true

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

source ~/.shplugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.shplugins/zsh-autopair/autopair.zsh

eval "$(navi widget zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
