#!/usr/bin/bash 
#MariaDB Backup script for Debian Linux VPS

echo "Connecting to server..." | ts | tee -a "$LOG_FILE"
#Variables
USERNAME="username"
REMOTE_HOST="123.111.123.111"
SSH_PORT=53732
FILENAME="mariadb-"$(date +%F_%T | tr ':' '-')".tar.gz"
BACKUP_DIR="/Backups/db" # local backup dir (NOT the full path)
REMOTE_BACKUP_DIR="/home/username/backups/db"
TMP_DIR="/home/username/.tmp" # remote tmp dir
# Define the device to check
HDD="/dev/sdd" # external hdd 
LOG_FILE="/home/username/Documents/custom_logs/db_backup.log"

# check if HDD is mounted
is_mounted() {
    findmnt -rno SOURCE $HDD >> $LOG_FILE
}

# Echo with timestamp and log function
timestamped_echo() {
    echo "$1" | ts | tee -a "$LOG_FILE"
}

if is_mounted; then
    MOUNT_POINT=$(findmnt -n -o TARGET --source $HDD) 
    FULL_BACKUP_DIR=$MOUNT_POINT$BACKUP_DIR
    timestamped_echo "$HDD is already mounted on $MOUNT_POINT." 
else
    timestamped_echo "$HDD is not mounted. Attempting to mount..."
    # using udisksctl instead of mount to make the script runnable without sudo 
    udisksctl mount -b $HDD >> "$LOG_FILE" 2>&1 
    
    # Check if the mounting was successful
    if is_mounted; then
        timestamped_echo "Mounting successful."
        MOUNT_POINT=$(findmnt -n -o TARGET --source $HDD) 
        FULL_BACKUP_DIR=$MOUNT_POINT$BACKUP_DIR
    else
        timestamped_echo "Failed to mount $HDD on $MOUNT_POINT. Please check for errors."
        exit 1
    fi
fi

#Creating Backup directory
ssh -p $SSH_PORT -i "/home/username/.ssh/config/username" \
    $USERNAME@$REMOTE_HOST "mkdir -p $REMOTE_BACKUP_DIR $TMP_DIR" \
    >> "$LOG_FILE" 2>&1

#Creating Backups with tar
ssh -p $SSH_PORT -i "/home/username/.ssh/config/username" \
    $USERNAME@$REMOTE_HOST \
    "sudo mariabackup --backup --target-dir=$TMP_DIR --user=root" \
    >> "$LOG_FILE" 2>&1

# Archiving 
ssh -p $SSH_PORT -i "/home/username/.ssh/config/username" \
    $USERNAME@$REMOTE_HOST \
    "sudo tar -czf ${REMOTE_BACKUP_DIR}/${FILENAME} $TMP_DIR" \
    >> "$LOG_FILE" 2>&1

#Downloading the Backup to local Arch Linux
mkdir -p $FULL_BACKUP_DIR
scp -P $SSH_PORT -i "/home/username/.ssh/config/username" \
    $USERNAME@$REMOTE_HOST:${REMOTE_BACKUP_DIR}/${FILENAME} $FULL_BACKUP_DIR \
    >> "$LOG_FILE" 2>&1

#Removing remote backup
ssh -p $SSH_PORT -i "/home/username/.ssh/config/username" \
    $USERNAME@$REMOTE_HOST \
    "rm -r $REMOTE_BACKUP_DIR; sudo rm -r $TMP_DIR" \
    >> "$LOG_FILE" 2>&1

# Check of the file was downloaded
if [ -e "$FULL_BACKUP_DIR/$FILENAME" ]; then
    timestamped_echo "Backup file backup_$TIMESTAMP.tar.gz has been created."

    # send KDE notification
    kdialog --passivepopup "The VPS backup has been successfully created and downloaded (backup_$TIMESTAMP.tar.gz)" --title "VPS backup complete" 5

else
    timestamped_echo "Failed to create the file $FULL_BACKUP_DIR/$FILENAME in $HDD. Please check for errors."
fi
