#!/bin/sh

termux-setup-storage

pkg upgrade -y

pkg install -y zsh neovim rclone git nodejs python python-pip nala curl

if [[ -d "$HOME"/.config ]]; then
    echo "XDG_CONFIG_HOME already exists"
else
    mkdir -v "$HOME"/.config
fi

mkdir "$HOME"/.shplugins

git clone "https://github.com/Aloxaf/fzf-tab" &&
    git clone "https://github.com/zsh-users/zsh-syntax-highlighting" &&
    git clone "https://github.com/hlissner/zsh-autopair" &&
    git clone "https://github.com/zsh-users/zsh-autosuggestions"

mv zsh-syntax-highlighting fzf-tab zsh-autopair zsh-autosuggestions "$HOME/.shplugins" &&
    git clone "https://github.com/catppuccin/zsh-syntax-highlighting" &&
    mv zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh "$HOME"/.shplugins/zsh-syntax-highlighting &&
    rm -rf "$HOME"/zsh-syntax-highlighting

curl "https://raw.githubusercontent.com/avoidaccount/dtfs/main/.zshrc" >"$HOME"/.zshrc

source "$HOME"/.zshrc

apt purge -y nano && pkg upgrade -y

nala install -y android-tools aria2 bat binutils busybox difftastic dust exiftool eza fastfetch fclones fd fdupes ffmpeg flac fzf gh gitui glow golang man maxcso navi nerdfix p7zip pkgtop procs ripgrep ripgrep-all rnr rust sd sox sqlite starship stylua tealdeer termux-api texlab topgrade w3m w3m-img wget which zoxide

git clone "https://github.com/avoidaccount/dtfs"

mv "$HOME"/dtfs/.zshrc "$HOME" &&
    mv -r "$HOME"/dtfs/.config "$HOME" &&
    mv "$HOME"/dtfs/.editorconfig "$HOME"

rm -rf "$HOME"/dtfs

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