#!/bin/bash

SUBJECT="Test email"
TO="phreolol@gmail.com"
BODY="This is a test email"
echo -e "Subject: $SUBJECT\nTo: $TO\n\n$BODY" | msmtp $TO
