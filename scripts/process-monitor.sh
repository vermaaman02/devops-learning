#!/bin/bash
# Process Monitor Script
# Author:  Aman Verma
# Purpose:  Monitor system processes and resource usage

echo "================================"
echo "   PROCESS MONITOR"
echo "================================"
echo ""

echo "Date/Time: $(date)"
# Show current timestamp

echo ""
echo "--- TOP 5 CPU-CONSUMING PROCESSES ---"
echo ""

ps aux --sort=-%cpu | head -n 6
# ps aux = all processes with details
# --sort=-%cpu = sort by CPU usage (highest first, - means descending)
# head -n 6 = show first 6 lines (1 header + 5 processes)

echo ""
echo "--- TOP 5 MEMORY-CONSUMING PROCESSES ---"
echo ""

ps aux --sort=-%mem | head -n 6
# --sort=-%mem = sort by memory usage

echo ""
echo "--- TOTAL PROCESSES ---"
echo ""

echo "Total running processes: $(ps aux | wc -l)"
# ps aux | wc -l = count number of lines (each line = 1 process)

echo ""
echo "--- SYSTEM LOAD AVERAGE ---"
echo ""

uptime
# uptime = how long system has been running + load average
# Load average = system load over 1, 5, 15 minutes

echo ""
echo "================================"
echo "   END OF REPORT"
echo "================================"

