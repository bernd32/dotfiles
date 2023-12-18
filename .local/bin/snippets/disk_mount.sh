#!/bin/bash

# Device to mount
device="/dev/sdd"

# Mount the device using udisksctl
output=$(udisksctl mount -b $device)

# Check if the mounting operation was successful
if [ $? -ne 0 ]; then
  echo "Failed to mount $device"
  exit 1
fi

# Extract the mount point from the output
mount_point=$(echo $output | grep -oP 'at \K\/.*(?=.$)')

# Output the mount point
echo "The mount point for $device is $mount point"

# Do something with the mount point if needed
# ...

exit 0
