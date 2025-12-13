#!/bin/bash
# Daily system report script
# Runs every day at 8 AM, saves report to file

REPORT_FILE=~/devops-learning/reports/system-report-$(date +%Y-%m-%d).txt
# $(date +%Y-%m-%d) = format:  2025-12-13
# Creates unique filename for each day

mkdir -p ~/devops-learning/reports
# -p = create parent dirs if needed

echo "=== DAILY SYSTEM REPORT ===" > $REPORT_FILE
echo "Date: $(date)" >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "--- Disk Usage ---" >> $REPORT_FILE
df -h >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "--- Memory Usage ---" >> $REPORT_FILE
free -h >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "--- Top 5 CPU Processes ---" >> $REPORT_FILE
ps aux --sort=-%cpu | head -n 6 >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "Report saved to: $REPORT_FILE"
