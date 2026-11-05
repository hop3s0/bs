#!/bin/sh

pkg install -y net-snmp mrtg apache24

mkdir -p /usr/local/etc/snmp
cp snmpd.conf /usr/local/etc/snmp/snmpd.conf
sysrc snmpd_enable=YES
service snmpd restart

mkdir -p /usr/local/etc/mrtg /usr/local/www/apache24/data/mrtg
cp mrtg.cfg /usr/local/etc/mrtg/mrtg.cfg
indexmaker /usr/local/etc/mrtg/mrtg.cfg > /usr/local/www/apache24/data/mrtg/index.html
env LANG=C mrtg /usr/local/etc/mrtg/mrtg.cfg
echo "@reboot root env LANG=C /usr/local/bin/mrtg /usr/local/etc/mrtg/mrtg.cfg" >> /etc/crontab

sysrc apache24_enable=YES
service apache24 restart
