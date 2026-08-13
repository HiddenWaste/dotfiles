gitacp() {
    # Check if a commit message was actually provided
    if [ -z "$1" ]; then
        echo "Error: You must provide a commit message."
        echo "Usage: gitacp \"your message here\""
        return 1
    fi

    git add . && \
    git commit -m "$1" && \
    git push
}

enter-container() {
    # Get the names of running containers and store them in an array
    # --format '{{.Names}}' ensures we only fetch the names, ignoring the headers
    mapfile -t containers < <(sudo docker ps --format '{{.Names}}')
    
    # Check if there are any running containers
    if [ ${#containers[@]} -eq 0 ]; then
        echo "No running Docker containers found."
        exit 1
    fi
    
    # Display the running containers with a 0-indexed number
    echo "Active Docker Containers:"
    echo "-------------------------"
    for i in "${!containers[@]}"; do
        echo "[$i] ${containers[$i]}"
    done
    echo "-------------------------"
    
    # Prompt the user for a selection
    read -p "Enter a number (0-$((${#containers[@]} - 1))) to drop into: " selection
    
    # Validate the input (checks if it's a valid integer within the range)
    if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -ge "${#containers[@]}" ]; then
        echo "Invalid selection. Exiting."
        exit 1
    fi
    
    # Get the name of the selected container
    chosen_container="${containers[$selection]}"
    
    echo "Dropping into $chosen_container..."
    
    # Attempt to drop into the container using bash, fallback to sh if bash isn't available
    sudo docker exec -it "$chosen_container" /bin/bash 2>/dev/null || \
    sudo docker exec -it "$chosen_container" /bin/sh
}

up() {
    # Detect OS
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
    else
        OS=$(uname -s)
    fi

    case "$OS" in # different packages and managers for different OS
        ubuntu|debian)
            echo "Ubuntu Detected. Updating apt packages..."
            sudo apt update && sudo apt upgrade -y
            sudo snap refresh
            ;;
        arch)
            echo "Arch Detected! Updating aur, pacman packages..."
            # yay handles both official pacman packages and AUR packages
            yay -Syu
            ;;
        *)
            echo "Unsupported OS: $OS"
            ;;
    esac

# CARGO
    echo "Checking Cargo..."
    # Handle Cargo updates if installed
    if command -v cargo &> /dev/null; then
        echo "--- Checking Cargo Packages ---"
        if command -v cargo-install-update &> /dev/null; then
            # The efficient way if you have the sub-tool installed
            cargo install-update -a
        else
            # Fallback: re-installs all currently installed cargo binaries to update them
            echo "cargo-install-update not found. Re-installing binaries to update..."
            cargo install $(cargo install --list | awk '/^[a-z0-9_-]+ v[0-9.]+:/ {print $1}')
        fi
    fi
}

repo-update() {
    # This function is to be used in a parent folder of a bunch of repos
    echo "Warning: This script will automatically perform git pulls"
    
    # Iterate through every item in the current directory
    for d in */ ; do
        # Check if the subdirectory contains a .git folder
        if [ -d "$d/.git" ]; then
            echo "Updating $d..."
    
            # Move into the directory, pull, and return back
            (cd "$d" && git pull)
        else
            echo "Skipping $d (not a git repo)"
        fi
    done

    echo "Everything should be up to date!"
}

restart-container() {
    # Fetch all container names (both running and stopped)
    mapfile -t containers < <(sudo docker ps -a --format '{{.Names}}')
    
    # Check if any containers exist
    if [ ${#containers[@]} -eq 0 ]; then
        echo "No Docker containers found."
        return 1
    fi
    
    # Display the containers with 0-indexed numbers
    echo "Available Docker Containers:"
    echo "-------------------------"
    for i in "${!containers[@]}"; do
        echo "[$i] ${containers[$i]}"
    done
    echo "-------------------------"
    
    # Prompt for selection
    read -p "Enter a number (0-$((${#containers[@]} - 1))) to restart: " selection
    
    # Validate input
    if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -ge "${#containers[@]}" ]; then
        echo "Invalid selection. Exiting."
        return 1
    fi
    
    # Target selected container
    chosen_container="${containers[$selection]}"
    
    echo "Restarting $chosen_container..."
    sudo docker restart "$chosen_container"
}
