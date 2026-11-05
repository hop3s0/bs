#!/bin/bash

PORT=${1:?usage: ./portcheck.sh PORT}

echo "Service registered for port $PORT (/etc/services):"
grep -w "$PORT/[tu][cd]p" /etc/services

if netstat -tulpn | grep -q ":$PORT "; then
    echo "Port $PORT open: YES"
    netstat -tulpn | grep -E "Proto|:$PORT "
else
    echo "Port $PORT open: NO"
fi
