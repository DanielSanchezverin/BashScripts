#!/bin/bash
  
echo "Enter the sftp username"
read tempuser
newuser=`sudo grep -i $tempuser /etc/passwd`
newgroup=`sudo grep -i sftp /etc/group`

if [ "${newuser:-NULL}" = "NULL" ]; then
        if [ "${newgroup:-NULL}" = "NULL" ]; then
                sudo group add sftp
                sudo useradd -G sftp $tempuser
                sudo passwd $tempuser
                sudo mkdir /var/www/home/$tempuser
                sudo chown $tempuser:sftp -R /var/www/home/$tempuser
                sudo echo "Match Group sftp
                ChrootDirectory /var/www/home
                X11Forwarding no
                AllowTcpForwarding no
                ForceCommand internal-sftp" >> /etc/ssh/sshd_config
                echo "User created successfully"
        else
                sudo useradd -G sftp $tempuser
                sudo passwd $tempuser
                sudo mkdir /var/www/home/$tempuser
                sudo chown $tempuser:sftp -R /var/www/home/$tempuser
                echo "User created successfully"
        fi
else
        echo "This user already exists"
        echo "Do you want to make this user sftp? [Y/n]"
        read char
        if [ $char = "y" ] || [ $char = "Y" ]; then
                if [ "${newgroup:-NULL}" = "NULL" ]; then
                        sudo group add sftp
                        sudo usermod -g sftp $tempuser
                        sudo mkdir /var/www/home/$tempuser
                        sudo chown $tempuser:sftp -R /var/www/home/$tempuser
                        echo "User created successfully"
                else
                        sudo usermod -g sftp $tempuser
                        sudo mkdir /var/www/home/$tempuser
                        sudo chown $tempuser:sftp -R /var/www/home/$tempuser
                        echo "User created successfully"
                fi
        fi
fi