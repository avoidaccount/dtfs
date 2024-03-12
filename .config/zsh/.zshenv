export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_RUNTIME_DIR=/run/user/"$UID"
export XDG_STATE_HOME="$HOME"/.local/state

export EDITOR=nvim
export LANG=en_US.UTF-8
export VISUAL=nvim

export HOSTNAME=android
export USER=daru

export KNOWLEDGE_BASE="$HOME"/wikimyro
export ZPLUGINS="$HOME"/.shplugins

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export PIPX_BIN_DIR="$XDG_DATA_HOME"/pipx/bin
export PIPX_MAN_DIR="$PREFIX"/share/man
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
export FZF_DEFAULT_OPTS_FILE="$XDG_CONFIG_HOME"/fzf/fzfrc

# global pager
export PAGER="nvim +Man!"

# pfetch config
export PF_INFO="ascii title os host kernel shell pkgs wm de editor memory palette"

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

export ZSH_AUTOSUGGEST_STRATEGY=(completion)