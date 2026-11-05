#!/bin/sh

IF=${1:-em0}

while true; do
    echo
    echo "===== NETWORK MENU - FreeBSD - interface $IF ====="
    echo "1) Interfaces and traffic counters  (netstat -i)"
    echo "2) Active TCP connections           (netstat -p tcp)"
    echo "3) Open ports and their programs    (sockstat -l)"
    echo "4) Routing table                    (netstat -rn)"
    echo "5) Default gateway                  (route get default)"
    echo "6) Card speed, duplex and link      (ifconfig)"
    echo "7) Card model and driver            (dmesg.boot)"
    echo "8) Traffic per second, 5 seconds    (netstat -w)"
    echo "9) TCP statistics                   (netstat -s)"
    echo "0) Exit"
    printf "Option: "
    read op
    echo
    case $op in
        1) echo "Ipkts/Ibytes = received, Opkts/Obytes = sent, Ierrs/Oerrs = errors"
           netstat -i -b -h -n ;;
        2) echo "Addresses are shown as IP.PORT"
           netstat -n -p tcp ;;
        3) echo "COMMAND and PID = program using the port"
           sockstat -4 -6 -l ;;
        4) echo "Flag G = goes through a router. link#N = directly connected"
           netstat -rn ;;
        5) route -n get default ;;
        6) echo "media = speed and duplex, status = cable connected or not"
           ifconfig $IF | grep -E "ether|inet |media|status" ;;
        7) grep "^$IF:" /var/run/dmesg.boot ;;
        8) netstat -I $IF -w 1 -q 5 ;;
        9) netstat -s -p tcp ;;
        0) exit ;;
        *) echo "Invalid option" ;;
    esac
done
