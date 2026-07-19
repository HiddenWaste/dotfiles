#!/bin/bash

# 1. Get the names of running containers and store them in an array
# --format '{{.Names}}' ensures we only fetch the names, ignoring the headers
mapfile -t containers < <(sudo docker ps --format '{{.Names}}')

# Check if there are any running containers
if [ ${#containers[@]} -eq 0 ]; then
    echo "No running Docker containers found."
    exit 1
fi

# 2. Display the running containers with a 0-indexed number
echo "Active Docker Containers:"
echo "-------------------------"
for i in "${!containers[@]}"; do
    echo "[$i] ${containers[$i]}"
done
echo "-------------------------"

# 3. Prompt the user for a selection
read -p "Enter a number (0-$((${#containers[@]} - 1))) to drop into: " selection

# 4. Validate the input (checks if it's a valid integer within the range)
if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -ge "${#containers[@]}" ]; then
    echo "Invalid selection. Exiting."
    exit 1
fi

# Get the name of the selected container
chosen_container="${containers[$selection]}"

echo "Dropping into $chosen_container..."

# 5. Attempt to drop into the container using bash, fallback to sh if bash isn't available
sudo docker exec -it "$chosen_container" /bin/bash 2>/dev/null || \
sudo docker exec -it "$chosen_container" /bin/sh
