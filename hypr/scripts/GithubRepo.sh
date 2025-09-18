#!/usr/bin/env bash

# Clone a repository into the current directory
# TODO: show notifications for the different steps
clone_repository() {
  local repository=$1
  if [ -z "$repository" ]; then
    echo "No repository selected."
  else
    gh repo clone "$repository" "$HOME/Documents/Katas/$repository"
  fi
}

# Get all repositories with gh (name + visibility)
all_my_repositories() {
  gh repo list \
    --limit 1000 \
    --json name,visibility \
    --jq '.[] | "\(.name) (\(.visibility))"'
}

# Tofi menu
tofi_dmenu() {
  tofi --prompt-text "󰊤 :" -c ~/.config/tofi/configV
}

main() {
  # Show repos in Tofi
  selection=$(all_my_repositories | tofi_dmenu)

  # Extract just the repo name before cloning
  repository=$(echo "$selection" | awk '{print $1}')
  clone_repository "$repository"
}

main
