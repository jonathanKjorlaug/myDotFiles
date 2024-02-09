#!/bin/zsh
CURRENT_PATH=~/.config/personalConfig

cd ~/.config/

ln -s $CURRENT_PATH/neofetch neofetch
ln -s $CURRENT_PATH/nvim nvim
ln -s $CURRENT_PATH/espanso espanso
ln -s $CURRENT_PATH/rclone rclone

cd ~
ln -s $CURRENT_PATH/.zsh .zsh
ln -s $CURRENT_PATH/.zsh/.zshrc .zshrc
