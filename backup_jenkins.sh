#!/bin/bash

# Set Jenkins home and backup directory
JENKINS_HOME="/var/lib/jenkins"
BACKUP_DIR="/var/lib/jenkins/backups"
TIMESTAMP=$(date +%Y%m%d%H%M%S)
BACKUP_FILE="jenkins_home_$TIMESTAMP.tar.gz"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Backup Jenkins home if it exists
if [ -d "$JENKINS_HOME" ]; then
  tar -czf "$BACKUP_DIR/$BACKUP_FILE" "$JENKINS_HOME" && echo "Backup created: $BACKUP_FILE"
else
  echo "Jenkins home not found."
fi

# Upload backup to S3 if it exists
if [ -f "$BACKUP_DIR/$BACKUP_FILE" ]; then
  aws s3 cp "$BACKUP_DIR/$BACKUP_FILE" s3://your-s3-bucket-name/ && echo "Backup uploaded to S3."
else
  echo "No backup file to upload."
fi
