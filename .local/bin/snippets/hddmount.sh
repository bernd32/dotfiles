#!/bin/bash

# Define the device to check
HDD="/dev/sdd"
# Define the mount point, ensure this directory exists beforehand
# For example, if the drive should be mounted on /mnt/sdd, make sure that /mnt/sdd exists.
MOUNT_POINT="/run/media/bernd/HITACHI_TOURO_4T"
LOG_FILE="/home/bernd/Documents/custom_logs/backup.log"

# Function to check if HDD is mounted
is_mounted() {
    findmnt -rn $HDD $MOUNT_POINT 
}

# Check if HDD is mounted
if is_mounted; then
    echo "$(date) $HDD is already mounted on $MOUNT_POINT." | tee -a $LOG_FILE
else
    echo "$(date) $HDD is not mounted. Attempting to mount..." | tee -a $LOG_FILE
    mkdir -p $MOUNT_POINT
    mount $HDD $MOUNT_POINT
    
    # Check if the mounting was successful

    if is_mounted; then
        echo "$(date) Mounting successful." | tee -a $LOG_FILE
    else
        echo "$(date) Failed to mount $HDD on $MOUNT_POINT. Please check for errors." | tee -a $LOG_FILE
        exit 1
    fi
fi

# Once the HDD is ensured to be mounted, create the empty file "test.txt"

# Provide a final output message to indicate success
if [ -e "$FILE_PATH" ]; then
    echo "$(date) A file named 'test.txt' has been created in $MOUNT_POINT." | tee -a $LOG_FILE
else
    echo "$(date) Failed to create the file 'test.txt' in $MOUNT_POINT. Please check for errors." | tee -a $LOG_FILE
fi
