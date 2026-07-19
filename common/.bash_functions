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
