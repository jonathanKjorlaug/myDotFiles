#!/bin/bash
CURRENT_PATH=~/.config

if [[ -z "$(command -v bombadil)" ]]; then
    echo "Toml bombadil not installed. Installing now."
    sudo pacman -Sy --noconfirm
	sudo pacman -Sq --noconfirm --needed toml-bombadil
fi

echo "Installing packages"

if [[ -n "$(command -v pacman)" ]]; then
    sudo pacman -Syu --noconfirm
	sudo pacman -Sq --noconfirm --needed \
        sl \
        neovim \
        zsh \
        eza \
        ttf-meslo-nerd \
        ttf-liberation \
        fzf \
        texlive \
        texlive-langeuropean \
        biber \
        ripgrep \
        fd \
        lazygit \
        wget \
        cmake \
        wezterm \
        fastfetch \
        zathura \
        zathura-pdf-mupdf \
        swaync \
        hyprland \
        waybar \
        rofi-wayland \
        npm \
        brigthnessctl \
        pamixer \
        pacman-contrib
fi

if [ -z $(which starship) ]; then
	curl -sS https://starship.rs/install.sh | sh
fi

if [ -z $(which cargo) ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh 
    cargo install tree-sitter-cli
fi

# Changing shell
if [ $SHELL != /usr/bin/zsh ] && [ $SHELL != /bin/zsh ]; then
	chsh -s /bin/zsh
fi 


cd ~/dotfiles
bombadil install
bombadil link
