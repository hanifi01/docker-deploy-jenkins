#!/bin/bash

# Set Jenkins home directory (adjust if necessary)
JENKINS_HOME="/var/lib/jenkins"

# Set the backup directory (adjust if necessary)
BACKUP_DIR="/var/lib/jenkins/backups"

# Ensure the backup directory exists
if [ ! -d "$BACKUP_DIR" ]; then
  echo "Backup directory does not exist. Creating it..."
  mkdir -p "$BACKUP_DIR"
fi

# Create a timestamp for the backup file
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Name the backup file
BACKUP_FILE="jenkins_home_$TIMESTAMP.tar.gz"

# Check if Jenkins home directory exists before backing up
if [ -d "$JENKINS_HOME" ]; then
  echo "Backing up Jenkins home directory..."

  # Create a backup of the Jenkins home directory using tar
  tar --warning=no-file-changed -czvf "$BACKUP_DIR/$BACKUP_FILE" "$JENKINS_HOME"

  # Check if the tar command succeeded
  if [ $? -eq 0 ]; then
    echo "Backup created successfully: $BACKUP_FILE"

    # Upload the backup to S3 (make sure AWS CLI is configured and available)
    aws s3 cp "$BACKUP_DIR/$BACKUP_FILE" s3://your-s3-bucket-name/

    # Check if the AWS CLI command succeeded
    if [ $? -eq 0 ]; then
      echo "Backup uploaded successfully to S3."
    else
      echo "Error uploading the backup to S3."
    fi
  else
    echo "Error creating the backup."
  fi
else
  echo "Jenkins home directory does not exist. Aborting backup."
  exit 1
fi
