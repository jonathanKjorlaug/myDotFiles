#!/bin/bash
CURRENT_PATH=~/.config/personalConfig

# Installing packages

if [[ -n "$(command -v dnf)" ]]; then
	sudo dnf install -y sl \
        neovim \
        zsh \
        eza \
        alacritty
fi 

if [[ -n "$(command -v apt)" ]]; then
	sudo apt install -y curl
	sudo apt install -y sl

	# Eza
	sudo apt update
	sudo apt install -y gpg
	sudo mkdir -p /etc/apt/keyrings
	wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
	echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
	sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
	sudo apt update
	sudo apt install -y eza

	# Neovim
	flatpak install flathub io.neovim.nvim
	flatpak run io.neovim.nvim

	sudo apt install -y neofetch
	sudo apt install -y zsh
fi

if [[ -n "$(command -v pacman)$" ]]; then
    sudo pacman -Syu --noconfirm
	sudo pacman -Sq --noconfirm --needed \
        sl \
        neovim \
        neofetch \
        zsh \
        eza \
        tmux \
        ttf-meslo-nerd \
        npm \
        alacritty
fi

if [ -z $(which starship) ]; then
	curl -sS https://starship.rs/install.sh | sh
fi

if [ -z $(which cargo) ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh 
fi

# Changing shell
if [ $SHELL != /usr/bin/zsh ] && [ $SHELL != /bin/zsh ]; then
	chsh -s /bin/zsh
fi 


# moving config files
cd ~/.config/
echo "continuing"

ln -fs $CURRENT_PATH/neofetch neofetch
ln -fs $CURRENT_PATH/nvim nvim
ln -fs $CURRENT_PATH/espanso espanso
ln -fs $CURRENT_PATH/tmux tmux
ln -fs $CURRENT_PATH/alacritty alacritty

rm -r neofetch/neofetch
rm -r nvim/nvim
rm -r espanso/espanso
rm -r tmux/tmux
rm -r alacritty/alacritty

cd ~
ln -fs $CURRENT_PATH/.zsh .zsh
ln -fs $CURRENT_PATH/.zsh/.zshrc .zshrc
