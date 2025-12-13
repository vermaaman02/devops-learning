# DevOps Scripts Collection

Author: **Aman Verma**  
Purpose: Learning DevOps through practical scripting

---

## 📜 Scripts Overview

### 1. `system-info.sh`

**Purpose:** Display comprehensive system information

**What it shows:**
- Hostname and OS details
- Kernel version and architecture
- CPU model and specifications
- Memory (RAM) usage
- Disk usage statistics
- Network IP addresses

**Usage:**
```bash
./system-info.sh
```

**Output:** Formatted system report with all critical information

---

### 2. `disk-usage-report.sh`

**Purpose:** Analyze and report disk space usage

**What it does:**
- Shows top 10 largest files/folders in a directory
- Sorts by size (largest first)
- Human-readable output (KB, MB, GB)
- Accepts directory path as argument

**Usage:**
```bash
./disk-usage-report.sh              # Analyze current folder
./disk-usage-report. sh /home        # Analyze specific folder
./disk-usage-report. sh ~/           # Analyze home directory
```

**Use case:** Find what's consuming disk space

---

### 3. `process-monitor.sh`

**Purpose:** Monitor system processes and resource usage

**What it shows:**
- Top 5 CPU-consuming processes
- Top 5 memory-consuming processes
- Total number of running processes
- System load average and uptime

**Usage:**
```bash
./process-monitor.sh
```

**Use case:** Quick system performance check

---

### 4. `auto-backup.sh`

**Purpose:** Automated backup with error handling and logging

**Features:**
- Creates compressed backup (tar.gz) of scripts directory
- Timestamped backup files
- Detailed logging to `backup. log`
- Automatically deletes backups older than 7 days
- Error handling and validation

**Usage:**
```bash
./auto-backup.sh
```

**Output location:** `~/devops-learning/backups/`

**Schedule with cron (daily at 2 AM):**
```bash
0 2 * * * /home/aman_verma/devops-learning/scripts/auto-backup.sh
```

---

### 5. `health-check.sh`

**Purpose:** Complete system health monitoring

**What it checks:**
- CPU usage (warns if > 80%)
- Memory usage (warns if > 80%)
- Disk usage (warns if > 80%)
- Critical service status (nginx, cron)

**Features:**
- Color-coded status indicators (✓/⚠️)
- Saves report to file with timestamp
- Displays results on screen and in file

**Usage:**
```bash
./health-check.sh
```

**Output:** `~/devops-learning/health-report-YYYYMMDD.txt`

**Schedule with cron (every 6 hours):**
```bash
0 */6 * * * /home/aman_verma/devops-learning/scripts/health-check.sh
```

---

### 6. `ping-monitor.sh`

**Purpose:** Network connectivity monitoring

**What it does:**
- Tests connectivity to multiple servers/websites
- Shows response time for reachable hosts
- Identifies unreachable servers
- Quick network diagnostics

**Monitored hosts:**
- google.com
- github.com
- 8.8.8.8 (Google DNS)
- 1.1.1.1 (Cloudflare DNS)

**Usage:**
```bash
./ping-monitor.sh
```

**Use case:** Troubleshoot network issues, verify internet connectivity

---

### 7. `devops-menu.sh`

**Purpose:** Interactive menu to run all DevOps tools

**Features:**
- User-friendly menu interface
- One-click access to all scripts
- Clear screen between operations
- Easy navigation

**Menu options:**
1. System Info
2. Health Check
3. Backup Scripts
4. Network Check
5. Service Status
6. Disk Usage Report
0. Exit

**Usage:**
```bash
./devops-menu. sh
```

**Use case:** Central dashboard for all DevOps operations

---

### 8. `service-watchdog.sh`

**Purpose:** Automatic service monitoring and recovery

**What it does:**
- Monitors critical services (nginx, cron)
- Automatically restarts stopped services
- Logs all actions with timestamps
- Sends alerts for restart failures

**Features:**
- Silent monitoring (runs in background)
- Detailed logging to `watchdog.log`
- Error recovery mechanism

**Usage:**
```bash
./service-watchdog.sh
```

**Schedule with cron (every 5 minutes):**
```bash
*/5 * * * * /home/aman_verma/devops-learning/scripts/service-watchdog.sh
```

**Check logs:**
```bash
cat ~/devops-learning/watchdog. log
```

---

## 🚀 Quick Start

### Make all scripts executable:
```bash
chmod +x *.sh
```

### Run any script:
```bash
./script-name.sh
```

### Use interactive menu (recommended for beginners):
```bash
./devops-menu.sh
```

---

## 🔧 Technologies & Commands Used

**Bash scripting concepts:**
- Variables and command substitution
- Functions with parameters
- If/else conditionals
- For/while loops
- Error handling and exit codes
- Logging and redirection

**Linux commands:**
- `ps`, `top` - Process management
- `du`, `df` - Disk usage
- `free` - Memory monitoring
- `lscpu`, `uname` - System info
- `ip`, `ping` - Network diagnostics
- `systemctl` - Service management
- `tar` - Archive/backup
- `find` - File search
- `grep`, `awk`, `sed` - Text processing

---

## 📅 Automation with Cron

### Recommended cron schedule: 

```bash
# Edit crontab
crontab -e

# Add these lines: 

# Daily backup at 2 AM
0 2 * * * /home/aman_verma/devops-learning/scripts/auto-backup.sh

# Health check every 6 hours
0 */6 * * * /home/aman_verma/devops-learning/scripts/health-check.sh

# Service watchdog every 5 minutes
*/5 * * * * /home/aman_verma/devops-learning/scripts/service-watchdog.sh

# Network check every hour
0 * * * * /home/aman_verma/devops-learning/scripts/ping-monitor.sh
```

---

## 📊 Project Structure

```
~/devops-learning/
├── scripts/
│   ├── system-info.sh
│   ├── disk-usage-report.sh
│   ├── process-monitor.sh
│   ├── auto-backup.sh
│   ├── health-check.sh
│   ├── ping-monitor.sh
│   ├── devops-menu.sh
│   ├── service-watchdog.sh
│   └── README.md
├── backups/
│   ├── scripts_backup_*. tar.gz
│   └── backup.log
├── reports/
│   └── health-report-*.txt
└── watchdog.log
```

---

## 🎯 Learning Goals Achieved

✅ Master Linux command line  
✅ Automate system administration tasks  
✅ Build production-ready DevOps scripts  
✅ Implement error handling and logging  
✅ Schedule tasks with cron  
✅ Monitor system health and services  
✅ Create interactive user interfaces  

---

## 📝 Notes

- All scripts include detailed comments for learning
- Scripts follow DevOps best practices
- Error handling implemented for production use
- Logging for troubleshooting and audit
- Modular design (functions, reusable code)

---

## 🔗 Repository

GitHub: `https://github.com/vermaaman02/devops-learning`

---

**Last Updated:** December 2025  
**Status:** Week 1 Complete - Linux & Bash Scripting Foundation
