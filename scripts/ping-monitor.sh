#!/bin/bash
# Monitor multiple servers/websites

# Servers to monitor
SERVERS=(
    "google.com"
    "github. com"
    "8.8.8.8"
    "1.1.1.1"
)

echo "=== NETWORK CONNECTIVITY CHECK ==="
echo "Time: $(date)"
echo ""

for SERVER in "${SERVERS[@]}"; do
    echo -n "Checking $SERVER... "
    # -n = no newline (print on same line)
    
    if ping -c 2 -W 2 $SERVER > /dev/null 2>&1; then
        # -c 2 = 2 packets
        # -W 2 = timeout 2 seconds
        # > /dev/null 2>&1 = hide all output
        
        # Get response time
        TIME=$(ping -c 1 $SERVER | grep "time=" | awk -F'time=' '{print $2}' | awk '{print $1}')
        echo "✓ UP ($TIME)"
    else
        echo "✗ DOWN"
    fi
done

echo ""
echo "=== CHECK COMPLETED ==="
