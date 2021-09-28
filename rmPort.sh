#!/bin/bash
  
echo "Enter the port to block"
read port
echo "Enter the protocol [tcp,udp,etc]"
read protocol

if [ -n $port ] && [ -n $protocol ]; then
        sudo iptables -A INPUT -p $protocol --dport $port -j DROP
        echo "Rule blocked correctly"
else
        echo "Missing data to block a port"
fi