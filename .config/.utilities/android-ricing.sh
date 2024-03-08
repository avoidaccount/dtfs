#!/bin/sh

termux-setup-storage

cd "$HOME"

pkg upgrade -y &&
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
    git clone "https://github.com/zsh-users/zsh-autosuggestions" &&
    git clone "https://github.com/joshskidmore/zsh-fzf-history-search"

mv zsh-syntax-highlighting fzf-tab zsh-autopair zsh-autosuggestions zsh-fzf-history-search "$HOME/.shplugins" &&
    git clone "https://github.com/catppuccin/zsh-syntax-highlighting" &&
    mv zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh "$HOME"/.shplugins/zsh-syntax-highlighting &&
    rm -rf "$HOME"/zsh-syntax-highlighting

curl "https://raw.githubusercontent.com/avoidaccount/dtfs/main/.zshrc" >"$HOME"/.zshrc

source "$HOME"/.zshrc

nala install -y android-tools aria2 bat binutils busybox difftastic dust exiftool eza fastfetch fclones fd fdupes ffmpeg flac fzf gh gitui glow golang man maxcso navi nerdfix openjdk-17 openjdk-17-source p7zip pandoc pkgtop procs ripgrep ripgrep-all rnr rust sd sox sqlite starship stylua tealdeer termux-api texlab texlive-installer topgrade w3m w3m-img wget which zoxide &&
    nala remove -y nano

git clone "https://github.com/avoidaccount/dtfs" &&
    mv "$HOME"/dtfs/.zshrc "$HOME" &&
    mv -r "$HOME"/dtfs/.config "$HOME" &&
    mv "$HOME"/dtfs/.editorconfig "$HOME" &&
    rm -rf "$HOME"/dtfs

pip install --no-input beautifulsoup4 pipx pylast pyyaml requests &&
    pipx install beets proselint pyright qobuz-dl yamlfix yamllint yt-dlp &&
    pipx install "https://github.com/mikf/gallery-dl/archive/master.tar.gz" &&
    pipx inject gallery-dl pyyaml yt-dlp &&
    pipx inject beets beautifulsoup4 pylast requests

git clone "https://github.com/beetbox/beets" &&
    mv "$HOME"/beets/extra/_beet /data/data/com.termux/files/usr/share/zsh/site-functions &&
    nala --install-completion zsh &&
    mv "$HOME"/.zfunc/_nala /data/data/com.termux/files/usr/share/zsh/site-functions &&
    rm -rf "$HOME"/.zfunc &&
    sd "fpath\+=~/.zfunc" "" "$HOME"/.zshrc

cargo install cargo-update shellharden stylua taplo-cli typos-cli

go install "github.com/editorconfig-checker/editorconfig-checker/v2/cmd/editorconfig-checker@latest" "mvdan.cc/sh/v3/cmd/shfmt@latest"

npm install bash-language-server markdownlint-cli textlint vscode-langservers-extracted yaml-language-server &&
    npm install textlint-rule-no-todo textlint-rule-no-start-duplicated-conjunction textlint-rule-max-comma textlint-rule-editorconfig textlint-rule-no-empty-section textlint-rule-no-empty-element textlint-rule-date-weekday-mismatch textlint-rule-period-in-list-item textlint-rule-period-in-header @textlint-rule/textlint-rule-no-invalid-control-character  textlint-rule-footnote-order textlint-rule-max-doc-width textlint-rule-doubled-spaces @textlint-rule/textlint-rule-no-duplicate-abbr textlint-rule-unexpanded-acronym textlint-rule-abbr-within-parentheses textlint-rule-common-misspellings textlint-rule-apostrophe  textlint-filter-rule-comments textlint-plugin-html textlint-plugin-latex2e

textlint-rule-terminology

rm /data/data/com.termux/files/usr/etc/motd

bat cache --build

termux-reload-settings &&
    topgrade &&
    cd &&
    clear &&
    history clean