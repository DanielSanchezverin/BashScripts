#!/bin/bash
  
n=$(ls $path | wc -l)
if [ $n -gt 7 ];
then
        j=$(($n - 7))
        for ((i=1; i<=$j; i++))
        do
                old=$(ls -lt $path | tail -1 | awk '{ print $9 }')
                aws s3 mv $path/$old s3://$bucket/
        done
fi