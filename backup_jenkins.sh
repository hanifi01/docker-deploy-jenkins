#!/bin/bash

# Set your JENKINS_HOME path (use the correct path on your system)
JENKINS_HOME="/var/lib/jenkins"  # Example, update to your actual path

# Set the backup directory path where you want to store the backup locally
BACKUP_DIR="/var/jenkins_backups"  # Update to your desired backup location

# Create a timestamp for the backup file
TIMESTAMP=$(date +\%Y\%m\%d\%H\%M\%S)

# Name of the backup file
BACKUP_FILE="jenkins_home_$TIMESTAMP.tar.gz"

# Create a backup of JENKINS_HOME directory
tar -czvf $BACKUP_DIR/$BACKUP_FILE $JENKINS_HOME

# Upload the backup to AWS S3 (make sure AWS CLI is configured)
aws s3 cp $BACKUP_DIR/$BACKUP_FILE s3://your-s3-bucket-name/

# Optional: Remove the local backup file after upload (if you want to delete it)
# rm $BACKUP_DIR/$BACKUP_FILE
