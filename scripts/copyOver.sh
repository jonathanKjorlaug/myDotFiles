# /bin/bash 

cd ~/.dotFiles/.config/ 

directories=(espanso fastfetch nvim wezterm zsh)

directories=("fastfetch" "nvim" "wezterm" "zsh")

for dir in "${directories[@]}"; do
    cp -rf $dir ~/.config/myDotFiles/.config/
done

cd ~/.dotFiles
cp -f .zshrc ~/.config/myDotFiles/

echo "Everything copied"
