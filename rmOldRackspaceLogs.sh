#!/bin/bash

# Directory where the old logs will be removed
pth="/var/log"
# Log name
log="rackspace-monitoring-agent.log"
# Command to calculate the number of files
n=$(ls $pth | grep $log | wc -l)
# If $n is greater than 15, the if is executed
if [ $n -gt 5 ];
then
        # We subtract the number of logs we want to keep
        j=$(($n - 5))
        # The for is executed until "i" reaches the value of $j
        for ((i=1; i<=$j; i++))
        do
                # ls -lt sorts files from newest to oldest
                # tail -1 extracts the last value that has been the oldest
                # awk '{ print $9 }' extracts the name of the file and stores it in the variable old
                old=$(ls -lt $pth | grep $log | tail -1 | awk '{ print $9 }')
                # We delete the oldest file
                rm $pth/$old
        done
fi
# We extract the number of lines of text in the log
o=$(wc $pth/$log | awk '{ print $1 }')
# If the number of lines $o is greater than 1 million then the if is executed
if [ $o -gt 1000000 ];
then
    # We create a temporary file
    touch $pth/rack
    # We extract the lines that we want to keep in the log file and save it to the temporary file
    tail -1000000 $pth/$log > $pth/rack
    # We replace the content of the log with the temporary file
    cat $pth/rack > $pth/$log
    # We delete the temporary file
    rm $pth/rack
fi