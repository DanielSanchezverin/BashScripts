#!/bin/bash
  
echo "Enter the port to open"
read port
echo "Enter the protocol [tcp,udp,etc]"
read protocol
echo "Enter the name of the security group"
read sg
echo "Enter the range of ip's with its prefix (example: 0.0.0.0/0)"
read ip

if [ -n $port ] && [ -n $protocol ] && [ -n sg ] && [ -n ip ]; then
        /bin/aws ec2 authorize-security-group-ingress --group-name $sg --protocol $protocol --port $port --cidr $ip
        ufw allow proto $protocol from $ip to any port $port
        echo "Security group and firewall configured correctly"
else
        echo "Missing data to continue"
fi