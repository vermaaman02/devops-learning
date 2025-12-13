#!/bin/bash

source ../config/toolkit.conf
# Load configuration variables
# Now we can use $CPU_THRESHOLD, $MAIN_LOG, etc.

LOG_MSG() {
    # Function to log messages
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$MAIN_LOG"
    # $(date '+%Y-%m-%d %H:%M:%S') = current timestamp
    # $1 = first parameter passed to function
    # | = pipe (send output to next command)
    # tee = write to file AND show on screen
    # -a = append (don't overwrite)
}

ALERT() {
    # Function for alerts (critical messages)
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ALERT: $1" | tee -a "$ALERT_LOG"
    # Same as LOG_MSG but writes to alert log
}

echo "=== SYSTEM HEALTH CHECK ==="
echo ""

# CPU Check
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
# Let me break this down:
# top -bn1 = run top command
#   -b = batch mode (non-interactive)
#   -n1 = 1 iteration (run once, don't loop)
# | grep "Cpu(s)" = filter line containing "Cpu(s)"
# | awk '{print $2}' = get 2nd column (CPU percentage)
# | cut -d'%' -f1 = remove % symbol
#   -d'%' = delimiter is %
#   -f1 = field 1 (before %)
# Result: "23.5" (just the number)

CPU_INT=${CPU_USAGE%.*}
# ${CPU_USAGE%.*} = remove decimal part
# Example: 23.5 becomes 23
# %.*  = remove . * pattern from end
# Why? Because we compare integers:  if [ 23 -gt 80 ]

echo "CPU Usage: ${CPU_USAGE}%"

if [ $CPU_INT -gt $CPU_THRESHOLD ]; then
    # -gt = greater than (for integers)
    # Compares CPU with threshold from config
    echo "⚠️  WARNING: High CPU!"
    ALERT "High CPU usage:  ${CPU_USAGE}%"
    # Calls ALERT function, writes to alert log
else
    echo "✓ CPU OK"
fi

echo ""

# Memory Check
MEM_USAGE=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')
# free = show memory statistics
# | grep Mem = filter "Mem" line (not Swap)
# | awk '{printf "%.0f", $3/$2 * 100}' = calculate percentage
#   $3 = used memory
#   $2 = total memory
#   $3/$2 * 100 = percentage
#   printf "%.0f" = format as integer (no decimals)

echo "Memory Usage: ${MEM_USAGE}%"

if [ $MEM_USAGE -gt $MEMORY_THRESHOLD ]; then
    echo "⚠️  WARNING:  High memory!"
    ALERT "High memory usage: ${MEM_USAGE}%"
else
    echo "✓ Memory OK"
fi

echo ""

# Disk Check
DISK_USAGE=$(df -h / | tail -n1 | awk '{print $5}' | sed 's/%//')
# df -h / = disk free, human-readable, root partition
# | tail -n1 = last line (data, not header)
# | awk '{print $5}' = 5th column (Use% column)
# | sed 's/%//' = remove % symbol
#   s = substitute
#   /%// = replace % with nothing

echo "Disk Usage: ${DISK_USAGE}%"

if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
    echo "⚠️  WARNING: High disk usage!"
    ALERT "High disk usage: ${DISK_USAGE}%"
else
    echo "✓ Disk OK"
fi

echo ""
LOG_MSG "Health check completed - CPU: ${CPU_USAGE}% MEM:${MEM_USAGE}% DISK:${DISK_USAGE}%"
# Log summary to main log file
