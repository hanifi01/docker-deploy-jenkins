#!/bin/bash

# Set the correct JENKINS_HOME path
JENKINS_HOME="/var/lib/jenkins"  # Replace this with the correct Jenkins home path

# Set backup destination directory (ensure it exists and is accessible)
BACKUP_DIR="/var/lib/jenkins/backups"  # Change if needed

# Check if the backup directory exists, create if not
if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p "$BACKUP_DIR"
fi

# Create a timestamp for the backup file
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Name the backup file
BACKUP_FILE="jenkins_home_$TIMESTAMP.tar.gz"

# Create a backup of the Jenkins home directory
tar -czvf $BACKUP_DIR/$BACKUP_FILE $JENKINS_HOME

# Upload the backup to S3 (ensure AWS CLI is configured)
aws s3 cp $BACKUP_DIR/$BACKUP_FILE s3://your-s3-bucket-name/

# Optional: Delete the local backup file after upload
# rm $BACKUP_DIR/$BACKUP_FILE
