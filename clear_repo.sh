#!/bin/bash

USERNAME="your_github_username"
TOKEN="your_github_token"

# Check for existence fzf
if ! command -v fzf &> /dev/null; then
    echo "You need install fzf (https://github.com/junegunn/fzf)"
    exit 1
fi

# Get list repo on Github (only your repo, not about fork)
REPOS=$(curl -s -u "$USERNAME:$TOKEN" "https://api.github.com/user/repos?per_page=100" | jq -r '.[] | select(.owner.login == "'"$USERNAME"'") | .name')

if [ -z "$REPOS" ]; then
    echo "Not found repo."
    exit 1
fi

# Select repo by fzf (Accept multiple selection)
SELECTED=$(echo "$REPOS" | fzf --multi --prompt="Select repo you want delete: ")

if [ -z "$SELECTED" ]; then
    echo "None selected."
    exit 0
fi

echo "You selected repo:"
echo "$SELECTED"
echo ""
read -p "Are you sure? (y/N): " confirm

if [[ "$confirm" != "y" ]]; then
    echo "Cancelled."
    exit 0
fi

while IFS= read -r repo; do
    echo "Deleting repo: $repo"
    response=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE -u "$USERNAME:$TOKEN" "https://api.github.com/repos/$USERNAME/$repo")
    if [ "$response" -eq 204 ]; then
        echo "Deleted: $repo"
    else
        echo "Fail $repo (HTTP $response)"
    fi
done <<< "$SELECTED"

