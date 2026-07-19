#!/bin/bash

# Define the files that commonly conflict
DEFAULTS=(
    "$HOME/.bashrc"
    # "$HOME/.bash_profile"
    # "$HOME/.logout"
    "$HOME/.bash_aliases"
    "$HOME/.bash_functions"
    "$HOME/.vimrc"
)

echo "Cleaning up default skeleton files..."
for file in "${DEFAULTS[@]}"; do
    if [ -f "$file" ] && [ ! -L "$file" ]; then
        echo "Removing regular file: $file"
        rm "$file"
    fi
done

echo "Stowing configurations..."
# stow -nv common # dry run (-n)
stow -v common
# Add machine detection logic here later if needed, e.g., stow -v project-car
