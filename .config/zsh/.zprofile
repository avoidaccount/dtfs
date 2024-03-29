export PATH=/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/share/texlive/bin:"$HOME"/.local/share/cargo/bin:"$HOME"/.local/share/go/bin:"$HOME"/.local/share/ltex-ls/bin:"$HOME"/.local/share/npm/bin:"$HOME"/.local/share/pipx/bin

reload() {
    clear &&
        termux-reload-settings &&
        source "$ZDOTDIR"/.zshrc
}

# fallback for creating a new bare repo
_dotfiles() {
    git --git-dir="$HOME"/.dtf/ --work-tree="$HOME" "$@"
}

dotfiles() {
    gitui --directory "$HOME"/.dtf/ --workdir "$HOME" "$@"
}

delete-empty-dirs() {
    find "$@" -type d -empty -delete -print
}

find-broken-symlinks() {
    find "$@" -type l ! -exec test -e {} \;
}

l() {
    eza --all --group-directories-first --git --hyperlink --long --sort=extension "$@"
}

ls() {
    eza --all --group-directories-first --hyperlink --sort=extension "$@"
}

lt() {
    eza --all --group-directories-first --hyperlink --ignore-glob=.git --sort=extension --tree "$@"
}

tcr() {
    tar --auto-compress --create --verbose --file="$@"
}

txr() {
    tar --extract --verbose --file="$@"
}

autodl-with-gdl() {
    gdl --input-file "$HOME"/.tools/gallery-dl/updates.txt
    termux-media-scan -r "/storage/emulated/0/Download"
}

batch-rename-pattern() {
    rnr --force --recursive --replace-limit=0 "$@"
}

check-xdg-dirs() {
    git clone --depth 1 "https://github.com/b3nj5m1n/xdg-ninja" &&
        cd xdg-ninja &&
        clear &&
        ./xdg-ninja.sh
    cd .. &&
        rm -rf "xdg-ninja"
}

dups-remove() {
    fclones group "$@" |
        fclones remove
}

gdl() {
    gallery-dl --config-yaml "$XDG_CONFIG_HOME"/gallery-dl/config.yaml "$@"
    fclones group "/storage/emulated/0/Download" |
        fclones remove
    delete-empty-dirs "/storage/emulated/0/Download"
    termux-media-scan -r "/storage/emulated/0/Download"
}

gdrive-file-dl() {
    gdown --fuzzy --output "/storage/emulated/0/Download" "$@"
}

gdrive-folder-dl() {
    gdown --folder --output "/storage/emulated/0/Download" "$@"
}

remote-sync() {
    rclone sync "$HOME"/.tools/gallery-dl "proton:dotdroid/.tools/gallery-dl" &&
        rclone sync "$HOME"/.tools/dicts "proton:dotdroid/.tools/dicts" &&
        rclone sync "$XDG_CONFIG_HOME"/beets/library.db "proton:dotdroid/beets" &&
        rclone sync "$XDG_CONFIG_HOME"/beets/state.pickle "proton:dotdroid/beets" &&
        rclone sync "$XDG_CONFIG_HOME"/fd "proton:dotdroid/fd" &&
        rclone sync "$XDG_CONFIG_HOME"/gallery-dl "proton:dotdroid/gallery-dl" &&
        rclone sync "$XDG_CONFIG_HOME"/git "proton:dotdroid/git" &&
        rclone sync "$XDG_CONFIG_HOME"/qobuz-dl "proton:dotdroid/qobuz-dl" &&
        rclone sync "$KNOWLEDGE_BASE" "proton:wikimyro" &&
        rclone sync "$HOME"/tcc "proton:archive/tcc"
}