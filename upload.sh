#!/bin/bash
# curl "https://raw.githubusercontent.com/andreafabrizi/Dropbox-Uploader/master/dropbox_uploader.sh" -o dropbox_uploader.sh

uploadscript=/home/pi/dropbox_uploader.sh
file=$(basename $1)
$uploadscript upload $1 {{ hostname }}/$file
