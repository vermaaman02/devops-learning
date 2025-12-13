#!/bin/bash
# Complete system health monitoring

REPORT_FILE=~/devops-learning/health-report-$(date +%Y%m%d).txt

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80

# Function: Check CPU usage
check_cpu() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    # top -bn1 = batch mode, 1 iteration
    # Extract CPU percentage
    
    CPU_INT=${CPU_USAGE%.*}
    # Remove decimal part
    
    echo "CPU Usage: ${CPU_USAGE}%"
    
    if [ $CPU_INT -gt $CPU_THRESHOLD ]; then
        echo "⚠️  WARNING: High CPU usage!"
    else
        echo "✓ CPU OK"
    fi
}

# Function: Check memory
check_memory() {
    MEM_USAGE=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')
    # Calculate memory percentage
    
    echo "Memory Usage: ${MEM_USAGE}%"
    
    if [ $MEM_USAGE -gt $MEM_THRESHOLD ]; then
        echo "⚠️  WARNING: High memory usage!"
    else
        echo "✓ Memory OK"
    fi
}

# Function: Check disk
check_disk() {
    DISK_USAGE=$(df -h / | tail -n1 | awk '{print $5}' | sed 's/%//')
    
    echo "Disk Usage: ${DISK_USAGE}%"
    
    if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
        echo "⚠️  WARNING: High disk usage!"
    else
        echo "✓ Disk OK"
    fi
}

# Function: Check critical services
check_services() {
    SERVICES=("cron" "nginx")
    
    echo ""
    echo "Service Status:"
    for SERVICE in "${SERVICES[@]}"; do
        if systemctl is-active --quiet $SERVICE; then
            echo "✓ $SERVICE - Running"
        else
            echo "✗ $SERVICE - Stopped"
        fi
    done
}

# Main execution
{
    echo "================================"
    echo "  SYSTEM HEALTH CHECK"
    echo "  $(date)"
    echo "================================"
    echo ""
    
    check_cpu
    echo ""
    
    check_memory
    echo ""
    
    check_disk
    
    check_services
    
    echo ""
    echo "================================"
} | tee $REPORT_FILE
# Everything inside { } is saved to file AND shown on screen

echo ""
echo "Report saved:  $REPORT_FILE"
