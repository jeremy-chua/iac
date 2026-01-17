#!/bin/bash
#########################################################
# Backup MongoDB to S3
##########################################################
set -e
echo "=== Starting MongoDB backup at $(date) ==="

TMP_DIR="/tmp"
BACKUP_DATE=$(date -u +"%Y-%m-%dT%H%M%SZ")
BACKUP_FILE="${BACKUP_DATE}_mongodump.gzip"
BACKUP_FILE_PATH="${TMP_DIR}/${BACKUP_FILE}"

echo "Checking /etc/environment"
echo " "
cat /etc/environment
echo " "

echo "Backing up MongoDB to ${TMP_DIR} at $(date)"
mongodump --archive=${BACKUP_FILE_PATH} --gzip
echo "Backup file created at ${BACKUP_FILE_PATH} at $(date)"
echo " "

echo "Copying backup to S3 bucket - ${APP_DATA_BUCKET} at $(date)"
aws s3 cp ${BACKUP_FILE_PATH} s3://${APP_DATA_BUCKET}/${BACKUP_FILE}
echo "Backup copied to S3 bucket at $(date)"
echo " "

echo "Clean up local backup file"
rm -vf ${BACKUP_FILE_PATH}
echo " "
echo "=== MongoDB backup completed at $(date) ==="
echo " "
echo " "
