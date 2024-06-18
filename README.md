### My (public) dotfiles!

This is a (somewhat) up-to-date version of my current dotfiles! Feel free to roast my formatting and other mistakes. As of now, they're based on using the best named dotfiles manager: Toml Bombadil. There's an install script included that's written for Arch Linux (btw) that should work if using arch. To do so, just clone the repo into your home directory, enter it, and run

    ./install.sh

If you aren't using arch, or don't want to use the install script, just install Toml Bombadil through your package manager, install the packages you deem necessary, do the steps as above, but instead of calling the install script, run:

    bombadil install
    bombadil link

As of writing, I am using wezterm as my terminal emulator, zsh as my shell, neovim as my main* editor, and most importantly of all: Fastfetch to make sure everyone knows I'm using Arch! (Because why else would it exist?!)

I am also exploiting the fact that I am currently on a summer break to experiment with hyprland as a tiling window manager. If you want to try out my current configuration, either copy the config files directly, or use the hyprland profile I've made for Toml Bombadil by running:

    bombadil link -p hyprland
