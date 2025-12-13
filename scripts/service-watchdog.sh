#!/bin/bash
# Service watchdog - auto-restart if stopped

SERVICES=("nginx" "cron")
LOG_FILE=~/devops-learning/watchdog. log

log_msg() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> $LOG_FILE
}

for SERVICE in "${SERVICES[@]}"; do
    if systemctl is-active --quiet $SERVICE; then
        log_msg "✓ $SERVICE is running"
    else
        log_msg "✗ $SERVICE is down - attempting restart"
        
        sudo systemctl start $SERVICE
        
        sleep 2
        
        if systemctl is-active --quiet $SERVICE; then
            log_msg "✓ $SERVICE restarted successfully"
        else
            log_msg "✗ CRITICAL: Failed to restart $SERVICE"
        fi
    fi
done
