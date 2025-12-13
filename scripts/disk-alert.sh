#!/bin/bash
# Disk space alert script
# Checks if disk usage > 80%, logs warning

THRESHOLD=80
# Alert if disk usage above 80%

USAGE=$(df -h / | tail -n 1 | awk '{print $5}' | sed 's/%//')
# df -h / = show disk usage of root partition
# tail -n 1 = last line (data line, not header)
# awk '{print $5}' = get 5th column (percentage)
# sed 's/%//' = remove % symbol

if [ $USAGE -gt $THRESHOLD ]; then
    # -gt = greater than
    echo "WARNING: Disk usage is ${USAGE}% (threshold: ${THRESHOLD}%)" >> ~/devops-learning/disk-alerts.log
    echo "Alert time: $(date)" >> ~/devops-learning/disk-alerts.log
fi

