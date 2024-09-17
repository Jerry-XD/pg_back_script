#!/bin/bash
# This script will backup the postgresql database
# and store it in a specified directory

# Constants
CONTAINER_NAME="postgresdb"
USER="admin"
# BACKUP_DIRECTORY="./backup"
BACKUP_DIRECTORY="/home/pg_backup/backup"

# Date stamp (formated YYYYMMDD)
# just used in file name
CURRENT_DATE=$(date "+%Y%m%d%H%M")

# Database named (command line argument) use pg_dump for backup
docker exec -t $CONTAINER_NAME pg_dumpall -c -U $USER > $BACKUP_DIRECTORY/backup_$CURRENT_DATE.sql
echo 'backup file finish'

# Cleanup old backups
find $BACKUP_DIRECTORY/* -mtime +7 -type f -exec rm -- '{}' \;
echo 'cleanup files older than 7 days finish'