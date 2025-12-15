#!/bin/bash
# Interactive DevOps menu

show_menu() {
    clear
    echo "================================"
    echo "   DEVOPS TOOLKIT MENU"
    echo "================================"
    echo "1. System Info"
    echo "2. Health Check"
    echo "3. Backup Scripts"
    echo "4. Network Check"
    echo "5. Service Status"
    echo "6. Disk Usage Report"
    echo "0. Exit"
    echo "===================================="
}

system_info() {
    ~/devops-learning/scripts/system-info.sh
    read -p "Press Enter to continue..."
}

health_check() {
    ~/devops-learning/scripts/health-check.sh
    read -p "Press Enter to continue..."
}

backup_scripts() {
    ~/devops-learning/scripts/auto-backup.sh
    read -p "Press Enter to continue..."
}

network_check() {
    ~/devops-learning/scripts/ping-monitor.sh
    read -p "Press Enter to continue..."
}

service_status() {
    systemctl list-units --type=service --state=running | head -n 20
    read -p "Press Enter to continue..."
}

disk_report() {
    ~/devops-learning/scripts/disk-usage-report.sh ~/
    read -p "Press Enter to continue..."
}

# Main loop
while true; do
    show_menu
    read -p "Enter choice [0-6]: " CHOICE
    
    case $CHOICE in
        1) system_info ;;
        2) health_check ;;
        3) backup_scripts ;;
        4) network_check ;;
        5) service_status ;;
        6) disk_report ;;
        0) 
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice!"
            sleep 2
            ;;
    esac
done
