# Zellij: configuration and layouts!
ln -sfn ~/code/dotfiles/common/.config/zellij/ ~/.config/
# TODO: figure out plugins

# Fastfetch
rm -rf ~/.config/fastfetch/*
mkdir -p ~/.config/fastfetch

ln -sfn ~/code/dotfiles/common/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
ln -sfn ~/code/dotfiles/common/.config/fastfetch/berserk.txt ~/.config/fastfetch/poke.txt
