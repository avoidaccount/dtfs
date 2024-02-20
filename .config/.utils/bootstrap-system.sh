#!/bin/sh

termux-setup-storage

pkg upgrade -y

pkg install zsh neovim rclone git nodejs python python-pip

if [[ -d "$HOME/.config" ]]; then
	echo "XDG_CONFIG_HOME already exists"
else
	mkdir -v "$HOME/.config"
fi

mkdir "$HOME/.shplugins"

git clone "https://github.com/zdharma-continuum/fast-syntax-highlighting" &&
	mv fast-syntax-highlighting "$HOME/.shplugins"

git clone "git clone https://github.com/Aloxaf/fzf-tab" &&
	mv fzf-tab "$HOME/.shplugins"

git clond "https://github.com/hlissner/zsh-autopair" &&
	mv zsh-autopair "$HOME/.shplugins"

apt purge nano &&
	pkg upgrade -y

pkg install 7zip aria2 bat binutils busybox difftastic dust exiftool eza fastfetch fclones fd fdupes ffmpeg flac fzf gh gitui glow golang gopass jql man navi nerdfix pkgtop procs ripgrep ripgrep-all rnr rust sd sox sqlite starship stylua tealdeer termux-api topgrade wget which zoxide

pip install --no-input beautifulsoup4 gallery-dl pyacoustid pylast pyyaml qobuz-dl requests yt-dlp

cargo install cargo-update typos-cli

mv "$HOME/.local/share/cargo/bin/*" "$PATH"

git clone "https://github.com/avoidaccount/dtfs"

mv "$HOME"/dtfs/.zshrc "$HOME" &&
	mv "$HOME"/dtfs/.config "$HOME"

rm -rf "$HOME"/dtfs

cd "$HOME" &&
	cd ../usr/etc &&
	rm motd &&
	cd

bat cache --build

termux-reload-settings

fast-theme XDG:catppuccin-mocha

topgrade

mkdir ~/.cache/zsh

compinit -d "~/.cache/zsh/zcompdump-$ZSH_VERSION"

cd && clear

history clear
