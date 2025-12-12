
#!/bin/bash
# Disk Usage Report Script
# Author:  Aman Verma
# Purpose: Show top 10 largest files/folders in a directory

TARGET_DIR=${1:-.}
# ${1:-.} means: 
# $1 = first argument passed to script
# : - = if no argument given, use default
# .  = current directory (default)
# So if you run ./disk-usage-report. sh /home, it uses /home
# If you run ./disk-usage-report.sh (no argument), it uses current folder

echo "================================"
echo "  DISK USAGE REPORT"
echo "================================"
echo ""
echo "Analyzing:  $TARGET_DIR"
echo ""

du -h "$TARGET_DIR" 2>/dev/null | sort -hr | head -n 10
# du = disk usage (shows size of files/folders)
# -h = human-readable (KB, MB, GB)
# "$TARGET_DIR" = the folder to analyze (in quotes for safety)
# 2>/dev/null = hide error messages (if some files not accessible)
# | = pipe (pass output to next command)
# sort -hr = sort in human-readable format, reverse order (largest first)
# head -n 10 = show only top 10 lines

echo ""
echo "================================"
echo "Done."
echo "================================"
