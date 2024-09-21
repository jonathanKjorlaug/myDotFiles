## Personal dotfiles for Jonathan Kjørlaug

If you see this, either you're me, or you've hacked into my github or something. In the latter case, good for you I guess, not that there's all that much useful stuff here (Unless you're just happening to be a year after me in Physics and Maths, then you might be able to find some (subpar) kok)

Anyways, there are two dependencies, git and GNU stow. Make sure to install them before running install.sh, which should do the rest of the job for you. For pacman run the following command:

    sudo pacman -S stow git github-cli

The last was to make your life slightly better by using the github-cli to clone the repo. Once you've installed the neccessary dependencies, first clone the repo using the following code:

    cd 
    gh auth login
    gh repo clone .dotFiles 

Finally, run the install script:

    .dotFiles/install.sh

You may thank me for the slight amount of work I've done in order to write this README
