#!/usr/bin/ksh

PORT=${1:?usage: ./portcheck.sh PORT}

echo "Service registered for port $PORT (/etc/services):"
grep -w "$PORT/[tu][cd]p" /etc/services

if netstat -an | egrep "\.$PORT .*(LISTEN|Idle)" > /dev/null; then
    echo "Port $PORT open: YES"
    netstat -anu | egrep "Local|\.$PORT .*(LISTEN|Idle)"
else
    echo "Port $PORT open: NO"
fi
