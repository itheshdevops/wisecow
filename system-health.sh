#!/bin/bash

# Thresholds (adjust these as needed)
CPU_THRESHOLD=80  # Percentage
MEMORY_THRESHOLD=80  # Percentage
DISK_THRESHOLD=80   # Percentage
PROCESS_THRESHOLD=500  # Number of processes

# Email configuration
TO_EMAIL="your.email@example.com"
FROM_EMAIL="system.alerts@example.com"
SMTP_SERVER="smtp.example.com"
SMTP_PORT="25"
SMTP_USER="your.smtp.username"
SMTP_PASSWORD="your.smtp.password"

# Function to send email alert
send_email_alert() {
    SUBJECT="System Health Alert"
    BODY="$1"
    echo -e "Subject:$SUBJECT\n$BODY" | \
    /usr/sbin/sendmail -S "$SMTP_SERVER:$SMTP_PORT" \
    -au"$SMTP_USER" -ap"$SMTP_PASSWORD" -f"$FROM_EMAIL" "$TO_EMAIL"
}

# Function to log alerts
log_alert() {
    MESSAGE="$1"
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $MESSAGE" >> /var/log/system_health.log
    send_email_alert "$MESSAGE"
}

# Check CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
if [ $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) -eq 1 ]; then
    log_alert "CPU usage is high: $CPU_USAGE%"
fi

# Check memory usage
MEMORY_USAGE=$(free | awk '/Mem/{printf "%.2f", $3/$2 * 100}')
if [ $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) -eq 1 ]; then
    log_alert "Memory usage is high: $MEMORY_USAGE%"
fi

# Check disk space
DISK_USAGE=$(df -h / | awk '/\//{print $(NF-1)}' | sed 's/%//')
if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
    log_alert "Disk usage is high: $DISK_USAGE%"
fi

# Check number of running processes
PROCESS_COUNT=$(ps aux | wc -l)
if [ $PROCESS_COUNT -gt $PROCESS_THRESHOLD ]; then
    log_alert "Number of processes exceeds threshold: $PROCESS_COUNT"
fi

# End of script
