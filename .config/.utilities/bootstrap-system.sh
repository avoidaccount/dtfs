#!/bin/sh

termux-setup-storage

pkg upgrade -y

pkg install zsh neovim rclone git nodejs python python-pip

if [[ -d "$HOME"/.config ]]; then
    echo "XDG_CONFIG_HOME already exists"
else
    mkdir -v "$HOME"/.config
fi

mkdir "$HOME"/.shplugins

git clone "https://github.com/zdharma-continuum/fast-syntax-highlighting" &&
    git clone "https://github.com/Aloxaf/fzf-tab" &&
    git clone "https://github.com/hlissner/zsh-autopair"

mv fast-syntax-highlighting fzf-tab zsh-autopair "$HOME/.shplugins"

apt purge nano && pkg upgrade -y

pkg install 7zip aria2 bat binutils busybox difftastic dust exiftool eza fastfetch fclones fd fdupes ffmpeg flac fzf gh gitui glow golang gopass jql man maxcso navi nerdfix pkgtop procs ripgrep ripgrep-all rnr rust sd sox sqlite starship stylua tealdeer termux-api texlab topgrade w3m w3m-img wget which zoxide

git clone "https://github.com/avoidaccount/dtfs"

mv "$HOME"/dtfs/.zshrc "$HOME" &&
    mv -r "$HOME"/dtfs/.config "$HOME" &&
    mv "$HOME"/dtfs/.editorconfig "$HOME"

rm -rf "$HOME"/dtfs

mkdir ~/.cache/zsh

compinit -d ~/.cache/zsh/zcompdump-"$ZSH_VERSION"

source "$HOME"/.zshrc

pip install --no-input beautifulsoup4 pipx pylast pyyaml requests

pipx install beets proselint pyright qobuz-dl yamlfix yamllint yt-dlp &&
    pipx install "https://github.com/mikf/gallery-dl/archive/master.tar.gz"

pipx inject gallery-dl pyyaml &&
    pipx inject beets beautifulsoup4 pylast requests

cargo install cargo-update shellharden stylua taplo-cli typos-cli

go install "github.com/editorconfig-checker/editorconfig-checker/v2/cmd/editorconfig-checker@latest" "mvdan.cc/sh/v3/cmd/shfmt@latest"

npm install bash-language-server markdownlint-cli vscode-langservers-extracted yaml-language-server

cd "$HOME" && cd ../usr/etc && rm motd && cd

bat cache --build

termux-reload-settings

fast-theme XDG:catppuccin-mocha

topgrade

cd && clear

history clear