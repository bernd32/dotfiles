
#!/usr/bin/bash 
#Backup script for Debian Linux VPS
#'moreutils' package is required to run this script (to the 'ts' utility which is making a timestamp input for the loging)

echo "Connecting to server..." | ts |  tee -a $LOG_FILE

#Variables
USERNAME=$(whoami)  
SSH_USERNAME="username" 
REMOTE_HOST="123.123.123.123"
PORT=53732
PATH_TO_SSH_KEY="/path/to/ssh/key"
TIMESTAMP=$(date +"%d-%m-%Y_%H-%M-%S")
BACKUP_DIR="/Backups/system" # local backup dir (NOT the full path)
REMOTE_BACKUP_DIR="/home/username/backups"
SOURCE_DIRS="/home /etc /root /usr /var"  
# Define the device to check
HDD="/dev/sdd" # external hdd 
LOG_FILE="/home/username/Documents/custom_logs/backup.log"

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
ssh -p $PORT -i "$PATH_TO_SSH_KEY" $SSH_USERNAME@$REMOTE_HOST \
    "mkdir -p $REMOTE_BACKUP_DIR" \
    >> "$LOG_FILE" 2>&1 # redirect stderr to stdout and then to a log file
timestamped_echo "Creating backup directory..."

#Creating Backups with tar
ssh -p $PORT -i "$PATH_TO_SSH_KEY" $SSH_USERNAME@$REMOTE_HOST \
    "sudo tar --exclude=$REMOTE_BACKUP_DIR \
    -czf $REMOTE_BACKUP_DIR/backup_$TIMESTAMP.tar.gz $SOURCE_DIRS" \
    >> "$LOG_FILE" 2>&1 
timestamped_echo "Creating Backups with tar" 

#Downloading the Backup to local Arch Linux
mkdir -p $FULL_BACKUP_DIR
scp -P $PORT -i "$PATH_TO_SSH_KEY" \
    $SSH_USERNAME@$REMOTE_HOST:$REMOTE_BACKUP_DIR/backup_$TIMESTAMP.tar.gz $FULL_BACKUP_DIR \
    >> "$LOG_FILE" 2>&1 
timestamped_echo "Downloading the backup to the local HDD ($FULL_BACKUP_DIR)... " 

#Deleting remote backup
ssh -p $PORT -i "$PATH_TO_SSH_KEY" $SSH_USERNAME@$REMOTE_HOST \
    "rm -r $REMOTE_BACKUP_DIR" \
    >> "$LOG_FILE" 2>&1 
timestamped_echo "Backup complete, sending email..."

# Check of the file was downloaded 
if [ -e "$FULL_BACKUP_DIR/backup_$TIMESTAMP.tar.gz" ]; then
    timestamped_echo "Backup file backup_$TIMESTAMP.tar.gz has been created." 

    # (Optional) Uncomment this block to Send notification via email 
#    SUBJECT="VPS backup complete"
#    TO="username@gmail.com"
#    BODY="The VPS backup has been successfully created and downloaded here: $FULL_BACKUP_DIR/backup_$TIMESTAMP.tar.gz" 
#    echo -e "Subject: $SUBJECT\nTo: $TO\n\n$BODY" | msmtp $TO >> "$LOG_FILE" 2>&1 
#    timestamped_echo "Mail sent"

    # send KDE notification
    kdialog --passivepopup "The VPS backup has been successfully created and downloaded (backup_$TIMESTAMP.tar.gz)" --title "VPS backup complete" 5

else
    timestamped_echo "Failed to create the file $FULL_BACKUP_DIR/backup_$TIMESTAMP.tar.gz in $HDD. Please check for errors." 
fi

