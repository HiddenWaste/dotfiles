#!/usr/bin/env bash
set -euo pipefail       # Exit on error, unset variables, or pipe failures

if ! command -v pass &>/dev/null; then       # Check if the pass utility is installed
    yay -Sy --needed --noconfirm pass sshpass  #  Install pass via pacman if it is missing
fi                                                                       

if [ ! -d "$HOME/.password-store" ]; then  # Check if password store directory does not exist
    if ! gpg --list-secret-keys | grep -q "^sec"; then # Check if any secret GPG keys exist on system
        echo "No GPG key found. Generating one now."  # Notify user of automatic key generation step
        echo "Choices: (1) RSA/RSA -> Keysize: 4096 -> Expiry: 0"       # Print recommended choices for key generation
        echo "Then enter your Name, Email, and a secure Passphrase."     # Print instructions for the personal info prompts
        gpg --full-generate-key   # Run interactive GPG key pair generation wizard
    fi           # End secret key existence check
    echo "Available GPG Keys:"    # Header for listing available keys
    gpg --list-secret-keys --keyid-format SHORT # Display installed secret keys with short key IDs
    echo ""             # Print an empty line for readability
    read -rp "Enter the GPG Key ID or Email to initialize pass with: " GPG_ID # Prompt user for key ID or email to encrypt with
    pass init "$GPG_ID" # Initialize pass password store with chosen key
fi                      # End password store initialization block

read -rp "How many tokens do you want to add? " NUM_SECRETS             # Prompt user for count of secrets to insert

for ((i = 1; i <= NUM_SECRETS; i++)); do  # Loop through total requested secret count
    echo "--- Secret $i of $NUM_SECRETS ---" # current secret iteration progress
    read -rp "Enter secret path/name (e.g. tokens/github): " SECRET_NAME # Prompt for secret path identifier
    pass insert "$SECRET_NAME" # Securely insert the secret via standard prompt
done                           # End secret insertion loop

# Now handle ssh passwords
read -rp "How many ssh passwords would you like to add? " NUM_SSH

for ((i=1; i <= NUM_SSH; i++)); do
    echo "---SSH PASS $i of $NUM_SSH ---"
    read -rp "Enter ssh pass path/name (e.g. ssh/web4) : " SECRET_NAME
    pass insert "$SECRET_NAME"
done
