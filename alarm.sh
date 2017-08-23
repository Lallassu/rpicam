#!/bin/bash

date=`date +"%Y-%m-%d %H:%M:%S"`
sleep 10
ffmpegthumbnailer -i $1 -o $1.png -q10 -s500 -t2
echo -e "ALERT: Motion detection($date), recorded to: $1 (CAMERA: $2)" | mutt -s "ALERT: Motion detection" -a $1.png -- {{ alarm_email_list }}
