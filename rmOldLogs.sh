#!/bin/bash

pth="$/var/log/apache2"
# Command to calculate the number of files
n=$(ls $pth | wc -l)
# If $n is greater than 15, the if is executed
if [ $n -gt 15 ];
then
        # We subtract the number of logs we want to keep
        j=$(($n - 15))
        # The for is executed until "i" reaches the value of $j
        for ((i=1; i<=$j; i++))
        do
                # ls -lt sorts files from newest to oldest
                # tail -1 extracts the last value that has been the oldest
                # awk '{ print $9 }' extracts the name of the file and stores it in the variable old
                old=$(ls -lt $pth | tail -1 | awk '{ print $9 }')
                # We delete the oldest file
                rm $old
        done
fi