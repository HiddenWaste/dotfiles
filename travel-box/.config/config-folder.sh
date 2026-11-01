# Create symbolic links for general .config stuffs!

# read in system name

# create links! keep in mind this forces the changes
ln -sfn ~/code/dotfiles/{$system}/.config/hypr/ ~/.config/
ln -sfn ~/code/dotfiles/{$system}/.config/kitty/ ~/.config/
ln -sfn ~/code/dotfiles/{$system}/.config/rofi/ ~/.config/

