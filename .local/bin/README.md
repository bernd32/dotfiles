# MariaDB Backup Script (db-backup.sh)

This shell script automates the process of backing up a MariaDB database on a  Linux VPS. The backup process involves connecting to the remote VPS, creating a backup using `mariabackup`, archiving it with `tar`, and then downloading the backup file to a local directory on an external hard drive mounted on `/dev/sdd`.

## Prerequisites

- The script assumes that the `moreutils` package is installed to use `ts` for timestamping log entries.
- SSH key-based authentication should be configured for connecting to the remote VPS without an interactive password prompt.
- The `udisksctl` command is used instead of `mount` to allow non-sudo users to mount the external HDD.
- The `kdialog` package should be installed if KDE desktop notifications are desired.

## Configuration

Before using this script, populate the following variables accordingly:

- `USERNAME`: Your SSH user for the remote VPS.
- `REMOTE_HOST`: The hostname or IP address of your remote VPS.
- `SSH_PORT`: The SSH port number (default is 22).
- `FILENAME`: The name of the backup file generated, containing the date and time.
- `BACKUP_DIR`: The local backup directory path where the backup file will be downloaded 
  (do not specify the full path if it's on an external HDD mounted afterward).
- `REMOTE_BACKUP_DIR`: The directory path on the remote VPS where the backup file will be temporarily stored.
- `TMP_DIR`: The temporary directory on the remote VPS where `mariabackup` will store its output.
- `HDD`: The device node of the external hard drive (change if not `/dev/sdd`).
- `LOG_FILE`: The path to the log file where all actions and errors will be logged.

Make sure to change `/path/to/ssh/key` to the actual path to your SSH private key.

# VPS System Backup Script (vps-backup.sh)

Automates the process of backing up important system directories from a Linux VPS to an external hard drive. It uses `tar` to create the backup archive remotely and then securely transfers it to a locally-mounted external HDD.

## Features

- Backup multiple system directories (`/home`, `/etc`, `/root`, `/usr`, `/var`)
- Timestamped backup files for easy version management
- Log all actions to a custom log file with timestamps
- Notification via email after successful backup
- Optional KDE desktop notifications upon completion

## Prerequisites

- The `moreutils` package must be installed to use the `ts` command for timestamped logging.
- SSH key-based authentication configured for remote VPS access.
- The `udisksctl` command available for mounting external HDD without needing sudo privileges.
- The `msmtp` package or another mail transfer agent configured for sending email notifications.
- For KDE desktop notifications, `kdialog` should be installed on the local system.

## Configuration

Before running the script, ensure you fill in the following variables inside the script:

- `USERNAME`: Your remote SSH username.
- `REMOTE_HOST`: The IP address or hostname of your remote VPS.
- `PORT`: The SSH port on your remote host (default is 22).
- `BACKUP_DIR`: The path to the directory where backups will be stored locally.
- `REMOTE_BACKUP_DIR`: The remote directory where temporary backups will be stored before being transferred.
- `HDD`: Your external HDD device path (by default `/dev/sdX`; replace `X` with the correct letter).
- `LOG_FILE`: The path to the log file for backup logs.
- `/path/to/ssh/key`: The path to your SSH private key used for authentication.

## Backup Process

The script performs the following steps:

1. Checks if the external HDD is mounted and attempts to mount it if needed.
2. Creates the backup directory on the remote host.
3. Creates tarball of specified directories, excluding the backup directory itself.
4. Downloads the backup tarball to the local backup directory.
5. Deletes the backup directory on the remote host.
6. Sends an email notification upon successful completion of the backup.
7. Optionally, displays a KDE desktop notification.

## Notifications

To receive email notifications upon successful backup, configure your local MTA (like `msmtp`) with the correct email settings and update the `TO` variable with your email address.

To receive KDE desktop notifications, ensure that `kdialog` is installed on your local system.

## Logging

All output and errors are logged to `LOG_FILE` as defined in the script. Check this log if any issues arise during the backup process.

## Known issues 
When the script is executed by Cron it will not mount a disk if it's not already mounted. The issue with mounting the drive when run by CRON stems from `udisksctl` requiring an active session to authenticate the mount operation. CRON jobs typically do not have an associated session, and as such, they cannot interact with the system's PolicyKit to gain authorization for mounting filesystems. One solution is to add your user to the disk group, or any other group that has permissions to access block devices, using `usermod` or `gpasswd`, i.e. `sudo usermod -aG disk username`. You can also customize policy kit rules to allow your user to mount devices without asking for a password. This can be done by creating a polkit rule file, but it should be done with caution to avoid security risks.

 

# Support & Contributions

For support or to contribute to the improvement, please open an issue or pull request in the GitHub repository. Your feedback and contributions are welcome!

