#!/bin/bash

HUBTEMP=`/usr/local/bin/tempmonitor -c -a -l -ds | grep "SMC AMBIENT AIR POSITION 2" | awk -F\:\  {'print $2'} | awk -F\  {'print $1'}`
echo -n $HUBTEMP > /Volumes/Technical/Web/80/statusboard/status
