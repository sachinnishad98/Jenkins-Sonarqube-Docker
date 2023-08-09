#!/bin/bash

# Get the current date in seconds since the epoch
current_date=$(date +%s)

# Calculate the timestamp for 1 minute ago
one_minute_ago=$((current_date - 60))  # 1 minute in seconds

# File to store the logs
log_file="deleted_branches.log"

# Clear the log file if it exists
> "$log_file"

# Iterate through local branches and delete those created within the last 1 minute
for branch in $(git branch --format='%(refname:short)'); do
    branch_date=$(git log -n 1 --format="%at" "$branch")
    if [ $branch_date -gt $one_minute_ago ]; then
        git branch -D "$branch"
        echo "Deleted branch $branch" >> "$log_file"
    fi
done

echo "Deleted branch logs have been saved to $log_file"
