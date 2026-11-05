#!/bin/sh

# HOME
HOST=192.168.2.200
# LAB (U)
#HOST=10.2.78.55

while true; do
    clear
    snmpget -v2c -c aysr -Os $HOST sysName.0 sysUpTime.0 ssCpuUser.0 ssCpuSystem.0 ssCpuIdle.0 memTotalReal.0 memAvailReal.0 dskPercent.1 hrSystemProcesses.0
    snmpwalk -v2c -c aysr -Os $HOST ifDescr
    snmpwalk -v2c -c aysr -Os $HOST ifInOctets
    snmpwalk -v2c -c aysr -Os $HOST ifOutOctets
    sleep 5
done
