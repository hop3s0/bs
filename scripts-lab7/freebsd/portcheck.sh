#!/bin/sh

PORT=${1:?usage: ./portcheck.sh PORT}

echo "Service registered for port $PORT (/etc/services):"
grep -w "$PORT/[tu][cd]p" /etc/services

if sockstat -4 -6 -l -p $PORT | grep -q ":$PORT "; then
    echo "Port $PORT open: YES"
    sockstat -4 -6 -l -p $PORT
else
    echo "Port $PORT open: NO"
fi
