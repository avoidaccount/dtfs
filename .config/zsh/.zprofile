export PATH=/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/share/texlive/bin:"$HOME"/.local/share/cargo/bin:"$HOME"/.local/share/go/bin:"$HOME"/.local/share/ltex-ls/bin:"$HOME"/.local/share/npm/bin:"$HOME"/.local/share/pipx/bin

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
    find "$@" -type l ! -exec test -e {} \; -print
}

l() {
    eza --all --group-directories-first --hyperlink --long --sort=extension "$@"
}

ls() {
    eza --all --group-directories-first --hyperlink --sort=extension "$@"
}

lt() {
    eza --all --group-directories-first --hyperlink --sort=extension --tree "$@"
}

autodl-with-gdl() {
    gdl --input-file "$HOME"/.utilities/gallery-dl/updates.txt
    termux-media-scan -r "/storage/emulated/0/Download"
}

batch-rename-pattern() {
    rnr --force --no-dump --recursive --replace-limit=0 "$@"
}

check-xdg-dirs() {
    git clone --depth 1 "https://github.com/b3nj5m1n/xdg-ninja" &&
        cd xdg-ninja &&
        clean &&
        ./xdg-ninja.sh
    cd .. &&
        rm -rf "xdg-ninja"
}

dups-remove() {
    fclones group "$@" |
        fclones remove
}

gdl() {
    gallery-dl --config-yaml "$XDG_CONFIG_HOME"/gallery-dl/config.yml "$@"
    termux-media-scan -r "/storage/emulated/0/Download"
}

gdrive-file-dl() {
    gdown --fuzzy --output "/storage/emulated/0/Download" "$@"
}

gdrive-folder-dl() {
    gdown --folder --output "/storage/emulated/0/Download" "$@"
}

proton-sync() {
    rclone sync "$HOME"/.utilities/gallery-dl "proton:dotdroid/.utilities/gallery-dl" &&
        rclone sync "$HOME"/.utilities/ltex "proton:dotdroid/.utilities/ltex" &&
        rclone sync "$XDG_CONFIG_HOME"/beets/library.db "proton:dotdroid/beets" &&
        rclone sync "$XDG_CONFIG_HOME"/beets/state.pickle "proton:dotdroid/beets" &&
        rclone sync "$XDG_CONFIG_HOME"/fd "proton:dotdroid/fd" &&
        rclone sync "$XDG_CONFIG_HOME"/gallery-dl "proton:dotdroid/gallery-dl" &&
        rclone sync "$XDG_CONFIG_HOME"/git "proton:dotdroid/git" &&
        rclone sync "$XDG_CONFIG_HOME"/qobuz-dl "proton:dotdroid/qobuz-dl" &&
        rclone sync "$KNOWLEDGE_BASE" "proton:wikimyro" &&
        rclone sync "$HOME"/tcc "proton:archive/tcc"
}

zarchive() {
    7z a -mx=0 "$@"
}

zxtract() {
    7z x -y "$@"
}