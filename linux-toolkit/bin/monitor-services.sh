#!/bin/bash

source ../config/toolkit.conf
# Load config (get $SERVICES list)

LOG_MSG() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$MAIN_LOG"
    # >> = append to file (don't show on screen this time)
}

ALERT() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ALERT: $1" >> "$ALERT_LOG"
}

echo "=== SERVICE STATUS CHECK ==="
echo ""

for SERVICE in $SERVICES; do
    # for loop iterates over each service in list
    # $SERVICES = "nginx cron ssh" (from config)
    # Loop runs 3 times:   SERVICE=nginx, then SERVICE=cron, then SERVICE=ssh
    
    if systemctl is-active --quiet $SERVICE 2>/dev/null; then
        # systemctl is-active = check if service is running
        # --quiet = don't print output (just return exit code)
        # 2>/dev/null = hide error messages
        #   2> = redirect stderr (error output)
        #   /dev/null = nowhere (delete it)
        # if command succeeds (exit code 0) = service is active
        
        echo "✓ $SERVICE - Running"
        LOG_MSG "$SERVICE is running"
    else
        # Service is not running
        echo "✗ $SERVICE - Stopped"
        ALERT "$SERVICE is not running!"
        
        # Auto-restart attempt
        echo "  Attempting to restart..."
        sudo systemctl start $SERVICE 2>/dev/null
        # sudo = run as root (services need root permission)
        # systemctl start = start the service
        
        sleep 2
        # Wait 2 seconds for service to start
        
        if systemctl is-active --quiet $SERVICE 2>/dev/null; then
            # Check again if now running
            echo "  ✓ Restart successful"
            LOG_MSG "$SERVICE restarted successfully"
        else
            echo "  ✗ Restart failed"
            ALERT "Failed to restart $SERVICE"
        fi
    fi
done
# Loop ends, back to "for" if more services

echo ""
