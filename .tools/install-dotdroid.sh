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

mv zsh-syntax-highlighting fzf-tab zsh-autopair zsh-autosuggestions zsh-fzf-history-search "$HOME"/.shplugins &&
    git clone --depth 1 "https://github.com/catppuccin/zsh-syntax-highlighting" &&
    mv zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh "$HOME"/.shplugins/zsh-syntax-highlighting &&
    rm -rf "$HOME"/zsh-syntax-highlighting

nala install -y android-tools ani-cli aria2 asciinema bat binutils busybox difftastic dua exiftool eza fclones fd fdupes ffmpeg figlet flac fzf gh gitui glow golang hollywood hyperfine inetutils libjxl-progs &&
    nala install -y man maxcso mtools navi nerdfix openjdk-17 openjdk-17-source p7zip pandoc pkgtop procs ripgrep ripgrep-all rnr rust sd sox sqlite starship stylua tealdeer termux-api texlab texlive-installer topgrade unzip w3m w3m-img wget which zoxide &&
    nala remove -y nano

git clone --depth 1 "https://github.com/xero/figlet-fonts" &&
    mv "$HOME"/figlet-fonts/maxiwi.flf "$PREFIX"/share/figlet &&
    rm -rf figlet-fonts

git clone --depth 1 "https://github.com/dylanaraps/pfetch" &&
    mv "$HOME"/pfetch/pfetch "$PREFIX"/bin &&
    rm -rf "$HOME"/pfetch

git clone "https://github.com/avoidaccount/dtfs" &&
    mv "$HOME"/dtfs/.config "$HOME" &&
    mv "$HOME"/dtfs/.editorconfig "$HOME" &&
    mv "$HOME"/dtfs/.taplo.toml "$HOME" &&
    mv "$HOME"/dtfs/.textlintrc.yml "$HOME" &&
    mv "$HOME"/dtfs/.utilities "$HOME"

pip install --no-input beautifulsoup4 pipx pylast pyyaml requests &&
    pipx install beets gdown pyright qobuz-dl yamlfix yamllint yt-dlp &&
    pipx install "https://github.com/mikf/gallery-dl/archive/master.tar.gz" &&
    pipx inject gallery-dl pyyaml yt-dlp &&
    pipx inject beets beautifulsoup4 pylast requests

git clone --depth 1 "https://github.com/beetbox/beets" &&
    mv "$HOME"/beets/extra/_beet "$PREFIX"/share/zsh/site-functions &&
    rm -rf "$HOME"/beets

git clone --depth 1 "https://gitlab.com/volian/nala.git" &&
    mv "$HOME"/nala/debian/_nala "$PREFIX"/share/zsh/site-functions &&
    rm -rf "$HOME"/nala

cargo install cargo-update shellharden stylua taplo-cli typos-cli

go install "mvdan.cc/sh/v3/cmd/shfmt@latest"

npm install bash-language-server markdownlint-cli textlint vscode-langservers-extracted yaml-language-server &&
    npm install textlint-rule-no-todo textlint-rule-no-start-duplicated-conjunction textlint-rule-max-comma textlint-rule-no-empty-section textlint-rule-no-empty-element &&
    npm install textlint-rule-date-weekday-mismatch textlint-rule-period-in-list-item textlint-rule-period-in-header textlint-rule-footnote-order textlint-rule-doubled-spaces textlint-rule-apostrophe textlint-filter-rule-comments textlint-plugin-html textlint-plugin-latex2e &&
    npm uninstall markdown-to-ast txt-ast-traverse &&
    npm install @textlint/markdown-to-ast @textlint/ast-traverse

rm "$PREFIX"/etc/motd

bat cache --build

topgrade

termux-reload-settings

history clean

chsh -s zsh