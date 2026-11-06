# Zellij: configuration and layouts!
ln -sfn ~/code/dotfiles/common/.config/zellij/ ~/.config/
# TODO: figure out plugins

# Fastfetch
rm -rf ~/.config/fastfetch/*
mkdir -p ~/.config/fastfetch

ln -sfn ~/code/dotfiles/common/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
ln -sfn ~/code/dotfiles/common/.config/fastfetch/fall-wizard.txt ~/.config/fastfetch/poke.txt


# Hyprland
#   While each system will have unique customizations, underlying keybinds and functionalities are needed to be shared

ln -sfn ~/code/dotfiles/common/.config/hypr/ ~/.config/
ln -sfn ~/code/dotfiles/common/.config/rofi/ ~/.config/
