#!/bin/bash

# Set your variables
organization="https://dev.azure.com/itsnational"
project="ITSN"
destination_dir="$HOME/repos"  # Directory where repositories will be cloned

# Ensure the destination directory exists
mkdir -p "$destination_dir"

# Get the list of repositories in the project
repos=$(az repos list --organization $organization --project $project --query "[].name" -o tsv)

# Iterate over each repository and clone it
for repo in $repos; do
    echo "Cloning repository: $repo"
    git clone "$organization/$project/_git/$repo" "$destination_dir/$repo"
done

echo "All repositories have been cloned."
