#!/bin/bash
space=$(df /mnt/ | awk 'NR==2 { print $5 }' | grep -o '^.')
DATE=$(date +%d-%m-%Y-%T)

if [ $space -le 95 ]
then
        sudo tar --exclude='.ssh' --exclude='.aws' -cvpzf /mnt/$DATE-fullbackup.tar.gz /home/*
        sudo tar -cvpzf /mnt/$DATE-logbackup.tar.gz /var/log/
        aws s3 sync /mnt s3://bucket/Backups --delete
        echo "Backup created succesfully"
        echo -e "Subject: Backup:Succesfully\n\nBackup ($DATE) created succesfully" | sendmail mail@mail.com
        echo "Correo Enviado"
else
        echo "Not enough space to backup"
        echo -e "Subject: Backup:Error\n\nBackup ($DATE) cannot be created. Not enough space to backup" | sendmail sendmail mail@mail.com
fi