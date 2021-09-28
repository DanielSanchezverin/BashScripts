#!/bin/bash

echo "Enter a ssh username"
read tempuser

newuser=`sudo grep -i $tempuser /etc/passwd`
newgroup=`sudo grep -i ssh /etc/group`

if [ "${newuser:-NULL}" = "NULL" ]; then
        if [ "${newgroup:-NULL}" = "NULL" ]; then
                sudo groupadd ssh
                sudo useradd -m -G ssh $tempuser
                sudo passwd $tempuser
                echo "Enter the name of the keys"
                read keyname
                sudo mkdir /home/$tempuser/.ssh/
                sudo chown $tempuser:ssh /home/$tempuser/.ssh/
                ssh-keygen -f /home/$tempuser/.ssh/$keyname -t rsa -N '' -C "$tempuser@$tempuser"
                echo "Keys generated: $keyname"
                sudo cat /home/$tempuser/.ssh/$keyname.pub > /home/$tempuser/.ssh/authorized_keys
                echo "ssh user created with successfully"
        else
                sudo useradd -m -G ssh $tempuser
                sudo passwd $tempuser
                echo "Enter the name of the keys"
                read keyname
                sudo mkdir /home/$tempuser/.ssh/
                sudo chown $tempuser:ssh /home/$tempuser/.ssh/
                ssh-keygen -f /home/$tempuser/.ssh/$keyname -t rsa -N '' -C "$tempuser@$tempuser"
                echo "Keys generated: $keyname"
                sudo cat /home/$tempuser/.ssh/$keyname.pub >> /home/$tempuser/.ssh/authorized_keys
                echo "ssh user created with successfully"
        fi
else
        echo "This user already exists"
        echo "Do you want to make this user ssh?? [Y/n]"
        read char
        if [ $char = "y" ] || [ $char = "Y" ]; then
                if [ "${newgroup:-NULL}" = "NULL" ]; then
                        sudo groupadd ssh
                        sudo usermod -g ssh
                        echo "Enter the name of the keys"
                        read keyname
                        sudo mkdir /home/$tempuser/.ssh/
                        sudo chown $tempuser:ssh /home/$tempuser/.ssh/
                        ssh-keygen -f /home/$tempuser/.ssh/$keyname -t rsa -N '' -C "$tempuser@$tempuser"
                        echo "Keys generated: $keyname"
                        sudo cat /home/$tempuser/.ssh/$keyname.pub >> /home/$tempuser/.ssh/authorized_keys
                        echo "ssh user created with successfully"
                else
                        sudo usermod -g ssh
                        echo "Enter the name of the keys"
                        read keyname
                        sudo mkdir /home/$tempuser/.ssh/
                        sudo chown $tempuser:ssh /home/$tempuser/.ssh/
                        ssh-keygen -f /home/$tempuser/.ssh/$keyname -t rsa -N '' -C "$tempuser@$tempuser"
                        echo "Keys generated: $keyname"
                        sudo cat /home/$tempuser/.ssh/$keyname.pub >> /home/$tempuser/.ssh/authorized_keys
                        echo "ssh user created with successfully"
                fi
        fi
fi