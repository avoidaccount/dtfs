#!/bin/sh

termux-setup-storage

cd "$HOME"

pkg upgrade -y &&
    pkg install -y zsh neovim rclone git nodejs python python-pip nala curl

touch "$PREFIX"/etc/zshenv &&
    echo 'export ZDOTDIR="$HOME"/.config/zsh' >"$PREFIX"/etc/zshenv

if [[ -d "$HOME"/.config ]]; then
    echo "XDG_CONFIG_HOME already exists"
else
    mkdir -v "$HOME"/.config
fi

mkdir "$HOME"/.shplugins

git clone --depth 1 "https://github.com/Aloxaf/fzf-tab" &&
    git clone --depth 1 "https://github.com/zsh-users/zsh-syntax-highlighting" &&
    git clone --depth 1 "https://github.com/hlissner/zsh-autopair" &&
    git clone --depth 1 "https://github.com/zsh-users/zsh-autosuggestions" &&
    git clone --depth 1 "https://github.com/joshskidmore/zsh-fzf-history-search"

mv zsh-syntax-highlighting fzf-tab zsh-autopair zsh-autosuggestions zsh-fzf-history-search "$HOME/.shplugins" &&
    git clone --depth 1 "https://github.com/catppuccin/zsh-syntax-highlighting" &&
    mv zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh "$HOME"/.shplugins/zsh-syntax-highlighting &&
    rm -rf "$HOME"/zsh-syntax-highlighting

nala install -y android-tools ani-cli aria2 bat binutils busybox difftastic dust exiftool eza fclones fd fdupes ffmpeg flac fzf gh gitui glow golang hollywood &&
    nala install -y man maxcso navi nerdfix openjdk-17 openjdk-17-source p7zip pandoc pkgtop procs ripgrep ripgrep-all rnr rust sd sox sqlite starship stylua tealdeer termux-api texlab texlive-installer topgrade w3m w3m-img wget which zoxide &&
    nala remove -y nano

git clone --depth 1 "https://github.com/dylanaraps/pfetch" &&
    mv "$HOME"/pfetch/pfetch "$PREFIX"/bin &&
    rm -rf "$HOME"/pfetch

git clone --depth 1 "https://github.com/avoidaccount/dtfs" &&
    mv "$HOME"/dtfs/.zshrc "$HOME" &&
    mv -r "$HOME"/dtfs/.config "$HOME" &&
    mv "$HOME"/dtfs/.editorconfig "$HOME" &&
    rm -rf "$HOME"/dtfs

pip install --no-input beautifulsoup4 pipx pylast pyyaml requests &&
    pipx install beets pyright qobuz-dl yamlfix yamllint yt-dlp &&
    pipx install "https://github.com/mikf/gallery-dl/archive/master.tar.gz" &&
    pipx inject gallery-dl pyyaml yt-dlp &&
    pipx inject beets beautifulsoup4 pylast requests

git clone --depth 1 "https://github.com/beetbox/beets" &&
    mv "$HOME"/beets/extra/_beet "$PREFIX"/share/zsh/site-functions &&
    nala --install-completion zsh &&
    mv "$HOME"/.zfunc/_nala "$PREFIX"/share/zsh/site-functions &&
    rm -rf "$HOME"/.zfunc &&
    sd "fpath\+=~/.zfunc" "" "$HOME"/.config/zsh/.zshrc

cargo install cargo-update shellharden stylua taplo-cli typos-cli

go install "github.com/editorconfig-checker/editorconfig-checker/v2/cmd/editorconfig-checker@latest" "mvdan.cc/sh/v3/cmd/shfmt@latest"

npm install bash-language-server markdownlint-cli textlint vscode-langservers-extracted yaml-language-server &&
    npm install textlint-rule-no-todo textlint-rule-no-start-duplicated-conjunction textlint-rule-max-comma textlint-rule-no-empty-section textlint-rule-no-empty-element textlint-rule-date-weekday-mismatch textlint-rule-period-in-list-item textlint-rule-period-in-header textlint-rule-footnote-order textlint-rule-doubled-spaces textlint-rule-apostrophe textlint-filter-rule-comments textlint-plugin-html textlint-plugin-latex2e &&
    npm uninstall markdown-to-ast txt-ast-traverse &&
    npm install @textlint/markdown-to-ast @textlint/ast-traverse

rm "$PREFIX"/etc/motd

bat cache --build

termux-reload-settings &&
    topgrade &&
    cd &&
    clear &&
    history clean &&
    chsh -s zsh