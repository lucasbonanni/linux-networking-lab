#!/bin/bash

current_date=$(date -u +"%Y-%m-%d_%H-%M-%S"z)

log_dir="/var/logs/backup.sh.logs"
logfile="$log_dir/backup-data1.sh_${current_date}.log"

# Set up log directory and file
if [[ ! -d "$log_dir" ]]; then
    mkdir -p "$log_dir"
fi

# Redirect standard error to logfile
exec 2>> "$logfile"

# Error handling function
function handle_error() {
    local exit_code=$?
    echo "An error occurred in line $1. Exiting script." >&2
    exit $exit_code
}

# Set error handling
trap 'handle_error $LINENO' ERR

# Define rsync command
rsync_command="rsync -vhaz --delete"
source_dir="/media/data1"
destination_dir="/media/backups"

# Execute rsync command
${rsync_command} "${source_dir}" "${destination_dir}"
