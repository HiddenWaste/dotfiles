read -p "Which Config? (project-car/cloudy): " PROFILE_NAME

COMMON_DIR="$HOME/code/dotfiles/common/"
PROFILE_DIR="$HOME/code/dotfiles/$PROFILE_NAME/"


# clean directories then create symlinks
rm ~/.bashrc ~/.bash_aliases ~/.bash_functions ~/.vimrc

ln -s ~/code/dotfiles/common/.bash_aliases ~
ln -s ~/code/dotfiles/common/.bash_functions ~
ln -s ~/code/dotfiles/common/.bashrc ~
ln -s ~/code/dotfiles/common/.vimrc ~

# FASTFETCH
rm ~/.config/fastfetch/*
ln -s "$COMMON_DIR/.config/fastfetch/config.jsonc" ~/.config/fastfetch/config.jsonc
ln -s "$COMMON_DIR/.config/fastfetch/$PROFILE_NAME.txt" ~/.config/fastfetch/poke.txt

# KITTY
rm ~/.config/kitty/*
ln -s "$COMMON_DIR/.config/kitty/kitty.conf" ~/.config/kitty/kitty.conf
ln -s "$COMMON_DIR/.config/kitty/$PROFILE_NAME.conf" ~/.config/kitty/override.conf

# HYPRLAND
rm -f ~/.config/hypr/hyprlock.conf ~/.config/hypr/hyprpaper.conf ~/.config/hypr/hypridle.conf
ln -s "$PROFILE_DIR/hypr/hyprpaper.conf" ~/.config/hypr/
ln -s "$PROFILE_DIR/hypr/hypridle.conf" ~/.config/hypr/
ln -sf "$PROFILE_DIR/hypr/hyprland.conf" ~/.config/hypr/hyprland.conf
ln -s "$PROFILE_DIR/hypr/hyprlock.conf" ~/.config/hypr/

# ZELLIJ
