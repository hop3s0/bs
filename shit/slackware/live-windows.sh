#!/bin/bash

HOST=10.2.78.57
IF=$(snmpget -v2c -c aysr -Oqv $HOST ipAdEntIfIndex.$HOST)

watch -n 5 "snmpget -v2c -c aysr -Os $HOST sysName.0 sysUpTime.0 hrSystemProcesses.0 hrSystemNumUsers.0 ifInOctets.$IF ifOutOctets.$IF
snmpwalk -v2c -c aysr -Os $HOST hrProcessorLoad
snmptable -v2c -c aysr -Cb $HOST hrStorageTable"
