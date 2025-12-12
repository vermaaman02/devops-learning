#!/bin/bash
# This line tells Linux:  "use bash shell to run this script"

# System Information Script
# Author:  Aman Verma
# Purpose: Show important system details

echo "================================"
# echo = print text on screen
echo "   SYSTEM INFORMATION REPORT"
echo "================================"
echo ""
# Empty line for spacing

echo "Hostname: $(hostname)"
# hostname = command that shows computer name
# $(... ) = run the command and insert its output here

echo "OS: $(uname -s)"
# uname -s = shows operating system name (Linux)

echo "Kernel: $(uname -r)"
# uname -r = shows kernel version (e.g., 5.15.0)

echo "Architecture: $(uname -m)"
# uname -m = shows CPU architecture (x86_64 = 64-bit)

echo ""

echo "Current User: $(whoami)"
# whoami = shows current logged-in username

echo "Date/Time: $(date)"
# date = shows current date and time

echo ""

echo "CPU Info:"
lscpu | grep "Model name"
# lscpu = shows detailed CPU information
# | = pipe (pass output to next command)
# grep "Model name" = filter only lines containing "Model name"

echo ""

echo "Memory Info:"
free -h
# free = shows RAM (memory) usage
# -h = human-readable format (GB, MB instead of bytes)

echo ""

echo "Disk Usage:"
df -h | grep -E '^/dev/'
# df = disk free (shows disk space usage)
# -h = human-readable
# grep -E '^/dev/' = show only lines starting with /dev/ (actual disks)

echo ""

echo "IP Addresses:"
ip addr show | grep "inet " | awk '{print $2}'
# ip addr show = shows network interfaces and IPs
# grep "inet " = filter lines with IP addresses
# awk '{print $2}' = print second column (the IP address)

echo ""

echo "================================"
echo "   END OF REPORT"
echo "================================"
