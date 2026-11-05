#!/usr/bin/ksh

PATH=$PATH:/usr/sbin
IF=${1:-net0}

while true; do
    echo
    echo "===== NETWORK MENU - Solaris - interface $IF ====="
    echo "1) Interfaces and packet counters   (netstat -i)"
    echo "2) Active TCP connections           (netstat -an -P tcp)"
    echo "3) Open ports and their programs    (netstat -anu)"
    echo "4) Routing table                    (netstat -rn)"
    echo "5) Default gateway                  (route get default)"
    echo "6) Card speed, duplex and driver    (dladm show-phys)"
    echo "7) Bytes sent and received          (dlstat show-link)"
    echo "8) Packets per second, 5 seconds    (netstat -i 1 5)"
    echo "9) TCP statistics                   (netstat -s)"
    echo "0) Exit"
    printf "Option: "
    read op
    echo
    case $op in
        1) echo "Ipkts = received, Opkts = sent, Ierrs/Oerrs = errors"
           netstat -i ;;
        2) echo "Addresses are shown as IP.PORT"
           netstat -an -f inet -P tcp ;;
        3) echo "LISTEN (TCP) or Idle (UDP) = open port. Pid and Command = program"
           netstat -anu | egrep "Local|LISTEN|Idle" ;;
        4) echo "Flag G = goes through a router"
           netstat -rn ;;
        5) route -n get default ;;
        6) echo "DEVICE = driver name + number (e1000g0 = driver e1000g)"
           dladm show-phys $IF ;;
        7) echo "RBYTES = received, OBYTES = sent (since the machine started)"
           dlstat show-link $IF ;;
        8) netstat -i -I $IF 1 5 ;;
        9) netstat -s -P tcp ;;
        0) exit ;;
        *) echo "Invalid option" ;;
    esac
done
