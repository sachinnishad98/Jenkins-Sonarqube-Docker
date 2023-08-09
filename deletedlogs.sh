#!/bin/bash

# Get the current date in seconds since the epoch
current_date=$(date +%s)

# Calculate the timestamp for 30 seconds ago
thirty_seconds_ago=$((current_date - 30))  # 30 seconds in seconds

# File to store the logs
log_file="deleted_branches.log"

# Clear the log file if it exists
> "$log_file"

# Iterate through local branches
for branch in $(git branch --format='%(refname:short)'); do
    if [ "$branch" != "main" ]; then
        branch_date=$(git log -n 1 --format="%at" "$branch")
        if [ $branch_date -gt $thirty_seconds_ago ]; then
            git branch -D "$branch"
            echo "Deleted branch $branch" >> "$log_file"
        fi
    fi
done

echo "Deleted branch logs have been saved to $log_file"
