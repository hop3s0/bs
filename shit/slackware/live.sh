#!/bin/bash

# HOME
HOST=192.168.2.203
# LAB (U)
#HOST=10.2.78.58

watch -n 5 "snmpget -v2c -c aysr -Os $HOST sysName.0 sysUpTime.0 ssCpuUser.0 ssCpuSystem.0 ssCpuIdle.0 memTotalReal.0 memAvailReal.0 dskPercent.1 hrSystemProcesses.0
snmpwalk -v2c -c aysr -Os $HOST ifDescr
snmpwalk -v2c -c aysr -Os $HOST ifInOctets
snmpwalk -v2c -c aysr -Os $HOST ifOutOctets"
