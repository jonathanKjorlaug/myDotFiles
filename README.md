### My (public) dotfiles!

This is a (somewhat) up-to-date version of my current dotfiles! Feel free to roast my formatting and other mistakes. As of now, they are designed to work with GNU stow. To do so, one must first install GNU stow, for instance by using:

    sudo pacman -S stow git

Yes, I use arch btw.

After doing this, clone the repo into your home directory, enter the repos directory, and run the command:

    stow . --adopt

There are some required dependencies for this setup to work properly, amongst them neovim, zsh, fastfetch and wezterm.
