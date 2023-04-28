#!/bin/bash

# Remove git commit history script for a specific branch
# Usage: ./remove_git_history.sh branch_name

set -e

if [ -z "$1" ]; then
  echo "You need to provide a branch name as an argument."
  exit 1
fi

branch_name="$1"

# Ensure the script is run from within a git repository
if ! git rev-parse --show-toplevel &> /dev/null; then
    echo "This script must be run within a Git repository."
    exit 1
fi

# Check if the branch exists
if ! git show-ref --verify --quiet "refs/heads/${branch_name}"; then
  echo "Branch '${branch_name}' not found."
  exit 1
fi

if [ "$(git symbolic-ref --short HEAD)" != "$branch_name" ]; then
  # Checkout the specified branch
  git checkout "${branch_name}"
fi

# Remove commit history
git checkout --orphan temp_branch
git add -A
git commit -m "Fresh start - removed commit history"
git branch -D "${branch_name}"
git branch -M temp_branch "${branch_name}"
git push -f origin "${branch_name}"

echo "Commit history removed successfully for branch '${branch_name}'."
