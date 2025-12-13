#!/bin/bash
# Shebang line - tells Linux:  "use bash to run this script"
# Must be first line in every bash script

# Linux System Monitoring & Automation Toolkit
# Comments explaining what this script does

# Load configuration
CONFIG_FILE="../config/toolkit.conf"
# .. / = parent directory (go up one level from bin/ to linux-toolkit/)
# Relative path:  bin/../config/toolkit.conf

if [ -f "$CONFIG_FILE" ]; then
    # if = conditional statement
    # [ ] = test command (checks condition)
    # -f = "file exists and is regular file" (not directory)
    # "$CONFIG_FILE" = variable in quotes (safe for spaces in path)
    
    source "$CONFIG_FILE"
    # source = load file and execute it
    # All variables from toolkit.conf become available here
    # After this line, you can use $CPU_THRESHOLD, $SERVICES, etc.
else
    echo "ERROR: Configuration file not found!"
    exit 1
    # exit 1 = exit script with error code 1 (non-zero = error)
fi

# Colors for output (ANSI escape codes)
RED='\033[0;31m'
# \033 = escape character (starts special sequence)
# [0;31m = red color code
GREEN='\033[0;32m'
# Green color
YELLOW='\033[1;33m'
# Yellow color (bold)
BLUE='\033[0;34m'
# Blue color
NC='\033[0m'
# NC = No Color (reset to default)
# Usage: echo -e "${RED}Error${NC}" = prints "Error" in red

# Function:  Display banner
show_banner() {
    # function_name() { } = function definition
    # Functions = reusable blocks of code
    
    clear
    # clear = clear terminal screen (like cls in Windows)
    
    echo -e "${BLUE}================================${NC}"
    # echo = print text
    # -e = enable interpretation of backslash escapes (for colors)
    # ${BLUE} = use BLUE variable value
    
    echo -e "${BLUE}  LINUX MONITORING TOOLKIT${NC}"
    echo -e "${BLUE}  Author: Aman Verma${NC}"
    echo -e "${BLUE}================================${NC}"
    echo ""
    # Empty line for spacing
}

# Function: Main menu
show_menu() {
    echo -e "${GREEN}Main Menu: ${NC}"
    echo "1. System Health Check"
    # Each option calls a different function
    echo "2. Service Status"
    echo "3. Network Diagnostics"
    echo "4. Create Backup"
    echo "5. View Recent Logs"
    echo "6. View Recent Alerts"
    echo "7. Generate Report"
    echo "8. Cleanup Old Files"
    echo "9. Start Monitoring (background)"
    echo "0. Exit"
    echo ""
}

# Function: System health
health_check() {
    echo -e "${YELLOW}Running health check...${NC}"
    ./monitor-health.sh
    # . / = current directory
    # Runs another script from same folder
    echo ""
    read -p "Press Enter to continue..."
    # read = wait for user input
    # -p = prompt message
    # Pauses until user presses Enter
}

# Function:  Service status
service_check() {
    echo -e "${YELLOW}Checking services...${NC}"
    ./monitor-services.sh
    # Calls monitor-services.sh script
    echo ""
    read -p "Press Enter to continue..."
}

# Function: Network diagnostics
network_check() {
    echo -e "${YELLOW}Running network diagnostics...${NC}"
    ./monitor-network.sh
    echo ""
    read -p "Press Enter to continue..."
}

# Function: Create backup
create_backup() {
    echo -e "${YELLOW}Creating backup...${NC}"
    ./create-backup.sh
    echo ""
    read -p "Press Enter to continue..."
}

# Function: View logs
view_logs() {
    echo -e "${YELLOW}Recent log entries:${NC}"
    tail -n 20 "$MAIN_LOG"
    # tail = show last lines of file
    # -n 20 = last 20 lines
    # $MAIN_LOG = variable from toolkit.conf
    echo ""
    read -p "Press Enter to continue..."
}

# Function: View alerts
view_alerts() {
    echo -e "${YELLOW}Recent alerts:${NC}"
    if [ -f "$ALERT_LOG" ]; then
        # Check if alert log file exists
        tail -n 20 "$ALERT_LOG"
    else
        echo "No alerts yet."
    fi
    echo ""
    read -p "Press Enter to continue..."
}

# Function: Generate report
generate_report() {
    echo -e "${YELLOW}Generating system report...${NC}"
    ./generate-report.sh
    echo ""
    read -p "Press Enter to continue..."
}

# Function: Cleanup
cleanup_files() {
    echo -e "${YELLOW}Cleaning up old files...${NC}"
    ./cleanup.sh
    echo ""
    read -p "Press Enter to continue..."
}

# Function: Start monitoring
start_monitoring() {
    echo -e "${YELLOW}Setting up automated monitoring...${NC}"
    ./setup-monitoring.sh
    echo ""
    read -p "Press Enter to continue..."
}

# Main loop
while true; do
    # while true = infinite loop (runs forever until break/exit)
    # true = always true condition
    
    show_banner
    # Call function (display banner)
    
    show_menu
    # Call function (display menu)
    
    read -p "Enter your choice [0-9]: " choice
    # Read user input, store in variable "choice"
    
    echo ""
    
    case $choice in
        # case = switch statement (like multiple if-else)
        # $choice = value to check
        
        1) health_check ;;
        # If choice = 1, call health_check function
        # ;; = end of this case
        
        2) service_check ;;
        3) network_check ;;
        4) create_backup ;;
        5) view_logs ;;
        6) view_alerts ;;
        7) generate_report ;;
        8) cleanup_files ;;
        9) start_monitoring ;;
        
        0) 
            echo -e "${GREEN}Goodbye!${NC}"
            exit 0
            # exit 0 = successful exit (no errors)
            ;;
            
        *)
            # * = default case (anything else)
            echo -e "${RED}Invalid choice! ${NC}"
            sleep 2
            # sleep 2 = wait 2 seconds
            ;;
    esac
    # esac = end of case statement (case spelled backwards)
done
# End of while loop
