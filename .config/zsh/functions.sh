# fallback for creating a new bare repo
_dotfiles() {
    git --git-dir="$HOME"/.dtf/ --work-tree="$HOME" "$@"
}

dotfiles() {
    gitui --directory "$HOME"/.dtf/ --workdir "$HOME" "$@"
}

cop() {
    cp --interactive --recursive --verbose "$@"
}

mdi() {
    mkdir --parents --verbose "$@"
}

mov() {
    mv --interactive --verbose "$@"
}

rem() {
    rm --force --recursive --verbose "$@"
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
    gdl --input-file "$XDG_CONFIG_HOME"/.utilities/gallery-dl/updates.txt
    termux-media-scan -r "/storage/emulated/0/gdl"
}

batch-rename-pattern() {
    rnr --force --no-dump --recursive --replace-limit=0 "$@"
}

check-xdg-dirs() {
    git clone "https://github.com/b3nj5m1n/xdg-ninja" &&
        cd xdg-ninja &&
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
    termux-media-scan -r "/storage/emulated/0/gdl"
}

gdrive-file-dl() {
    gdown --fuzzy --output "/storage/emulated/0/Download" "$@"
}

gdrive-folder-dl() {
    gdown --folder --output "/storage/emulated/0/Download" "$@"
}

mdlint() {
    markdownlint --config "$XDG_CONFIG_HOME"/.utilities/markdownlint.yaml --json --output ".tmplint.json" "$@"
    bat ".tmplint.json"
    rm ".tmplint.json"
}

sync-with-proton() {
    rclone sync "$XDG_CONFIG_HOME"/.utilities/gallery-dl "proton:dotdroid/.utilities/gallery-dl" &&
        rclone sync "$XDG_CONFIG_HOME"/beets/library.db "proton:dotdroid/beets" &&
        rclone sync "$XDG_CONFIG_HOME"/beets/state.pickle "proton:dotdroid/beets" &&
        rclone sync "$XDG_CONFIG_HOME"/fd "proton:dotdroid/fd" &&
        rclone sync "$XDG_CONFIG_HOME"/gallery-dl "proton:dotdroid/gallery-dl" &&
        rclone sync "$XDG_CONFIG_HOME"/git "proton:dotdroid/git" &&
        rclone sync "$XDG_CONFIG_HOME"/qobuz-dl "proton:dotdroid/qobuz-dl" &&
        rclone sync "$HOME"/wikimyro "proton:wikimyro" &&
        rclone sync "$HOME"/tcc "proton:archive/tcc"
}

zarchive() {
    7z a -mx=0 "$@"
}

zxtract() {
    7z x -y "$@"
}