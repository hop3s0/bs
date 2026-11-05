#!/bin/bash

cp snmpd.conf /etc/snmp/snmpd.conf
chmod +x /etc/rc.d/rc.snmpd
/etc/rc.d/rc.snmpd restart

wget https://oss.oetiker.ch/mrtg/pub/mrtg-2.17.10.tar.gz
tar xzf mrtg-2.17.10.tar.gz
cd mrtg-2.17.10
./configure --prefix=/usr/local
make
make install
cd ..

mkdir -p /etc/mrtg /srv/httpd/htdocs/mrtg
cp mrtg.cfg /etc/mrtg/mrtg.cfg
/usr/local/bin/indexmaker /etc/mrtg/mrtg.cfg > /srv/httpd/htdocs/mrtg/index.html
env LANG=C /usr/local/bin/mrtg /etc/mrtg/mrtg.cfg
echo "env LANG=C /usr/local/bin/mrtg /etc/mrtg/mrtg.cfg" >> /etc/rc.d/rc.local

chmod +x /etc/rc.d/rc.httpd
/etc/rc.d/rc.httpd start
