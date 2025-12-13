#!/bin/bash
# Professional backup script with error handling

# Configuration
BACKUP_DIR=~/devops-learning/backups
SOURCE_DIR=~/devops-learning/scripts
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/scripts_backup_$TIMESTAMP.tar.gz"
LOG_FILE="$BACKUP_DIR/backup. log"

# Function: Log message
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a $LOG_FILE
    # tee = write to file AND show on screen
    # -a = append
}

# Create backup directory if not exists
mkdir -p $BACKUP_DIR

log_message "=== BACKUP STARTED ==="

# Check if source directory exists
if [ !  -d "$SOURCE_DIR" ]; then
    # !  = NOT, -d = directory exists
    log_message "ERROR: Source directory $SOURCE_DIR not found"
    exit 1
fi

# Create backup
log_message "Creating backup of $SOURCE_DIR..."
if tar -czf $BACKUP_FILE $SOURCE_DIR 2>/dev/null; then
    # if command succeeds (exit code 0)
    SIZE=$(du -sh $BACKUP_FILE | awk '{print $1}')
    log_message "SUCCESS: Backup created - $BACKUP_FILE ($SIZE)"
else
    log_message "ERROR: Backup failed"
    exit 1
fi

# Delete backups older than 7 days
log_message "Cleaning old backups..."
find $BACKUP_DIR -name "scripts_backup_*.tar.gz" -type f -mtime +7 -delete
# -mtime +7 = modified more than 7 days ago
# -delete = delete found files

log_message "=== BACKUP COMPLETED ==="
