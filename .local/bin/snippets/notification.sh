#!/bin/bash

# KDE Plasma 5 Simple Popup Notification Script

# Set the notification title and message
NOTIFICATION_TITLE="Hello"
NOTIFICATION_MESSAGE="This is a simple pop-up notification in KDE Plasma 5."

# Use kdialog to create a passive popup
kdialog --passivepopup "${NOTIFICATION_MESSAGE}" --title "${NOTIFICATION_TITLE}" 5

# The number '5' at the end of the command indicates the duration in seconds 
# for which the notification will remain on the screen
