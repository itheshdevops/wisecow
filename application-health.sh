#!/bin/bash

# Configuration
APP_URL="http://example.com"  # Replace with your application's URL
EXPECTED_STATUS_CODE="200"    # Expected HTTP status code indicating the application is 'up'
TIMEOUT_SECONDS=10            # Timeout duration in seconds for curl requests

# Function to check application health
check_application_health() {
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout $TIMEOUT_SECONDS "$APP_URL")
    
    if [ $? -ne 0 ]; then
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Application is DOWN or not responding (curl failed)"
    elif [ "$HTTP_STATUS" = "$EXPECTED_STATUS_CODE" ]; then
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Application is UP (HTTP Status: $HTTP_STATUS)"
    else
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Application is available but returned HTTP Status: $HTTP_STATUS"
    fi
}

# Check application health
check_application_health

# End of script
