#!/usr/bin/env bash
set -euo pipefail

# Create target directory
mkdir -p ~/code/codebase

# Read Bitbucket API token securely (silent input)
read -rsp "Enter Bitbucket API Token: " BIT_API
echo

# Read Bitbucket username
read -rp "Enter Bitbucket Username: " BIT_USER

# Array of repository names
REPO_NAMES=(
  "usf-webapps"
  "webadmin"
  "apps-site"
  "usf"
  "api"
  "web4-utils"
  "utilities"
)

# Clone each repository into ~/code/codebase
for REPO in "${REPO_NAMES[@]}"; do
  echo "Cloning ${REPO}..."
  git clone "https://${BIT_USER}:${BIT_API}@bitbucket.org/usiouxfalls/${REPO}.git" "$HOME/code/codebase/${REPO}"
done

echo "Finished cloning all repositories."
