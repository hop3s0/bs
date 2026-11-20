#!/bin/bash

cp snmpd.conf /etc/snmp/snmpd.conf
chmod +x /etc/rc.d/rc.snmpd
/etc/rc.d/rc.snmpd restart
