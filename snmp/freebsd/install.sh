#!/bin/sh

pkg install -y net-snmp

mkdir -p /usr/local/etc/snmp
cp snmpd.conf /usr/local/etc/snmp/snmpd.conf
sysrc snmpd_enable=YES
service snmpd restart
