#!/bin/bash
RUN="/usr/bin/screen -dmS motion /usr/bin/motion"
CHECK=`ps axuf|grep -i "/usr/bin/motion" |grep -v grep`
if [ $? == 1 ]; then
  eval $RUN &
fi
