#!/bin/bash

PATH=$PATH:/sbin:/usr/sbin
IF=${1:-eth0}

while true; do
    echo
    echo "===== NETWORK MENU - Slackware - interface $IF ====="
    echo "1) Interfaces and packet counters   (netstat -i)"
    echo "2) Active TCP connections           (netstat -tn)"
    echo "3) Open ports and their programs    (netstat -tulpn)"
    echo "4) Routing table                    (route -n)"
    echo "5) Card speed, duplex and link      (ethtool)"
    echo "6) Card driver                      (ethtool -i)"
    echo "7) Bytes sent and received          (ip -s link)"
    echo "8) Traffic per second, 5 seconds    (sar -n DEV)"
    echo "9) TCP statistics                   (netstat -st)"
    echo "0) Exit"
    read -p "Option: " op
    echo
    case $op in
        1) echo "RX = received, TX = sent, ERR = errors, DRP = dropped"
           netstat -i ;;
        2) echo "Local IP:port -> remote IP:port and the state of the connection"
           netstat -tn ;;
        3) echo "LISTEN = waiting for connections. Last column = PID/program"
           netstat -tulpn ;;
        4) echo "Destination 0.0.0.0 = default route. Flag G = goes through a router"
           route -n ;;
        5) ethtool $IF | grep -E "Speed|Duplex|Auto-negotiation|Link detected" ;;
        6) ethtool -i $IF ;;
        7) echo "Counters since the machine started"
           ip -s link show $IF ;;
        8) echo "rxkB/s = KB received per second, txkB/s = KB sent per second"
           sar -n DEV 1 5 | grep -E "IFACE|$IF" ;;
        9) netstat -st ;;
        0) exit ;;
        *) echo "Invalid option" ;;
    esac
done
