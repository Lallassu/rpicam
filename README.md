# Automated Raspberry PI Camera Surveillance Setup
![RPI 3 with camera inside relativly-waterproof box with night vision](https://github.com/Lallassu/rpicam/blob/master/camera.jpg)

## About
This is a Ansible scripted automated setup of an Raspberry PI with an attached camera.

After running the script the raspberry will have the surveillance software "motion" running
with cronjobs and scripts setup to make it run after reboot. It will record files as avi and save
to the tmpfs mounted directory /home/pi/Dropbox/<rpi_hostname>.

The reason for saving recordings to a tmpfs filesystem is that the memory card will otherwise be
trashed after a while with too many read/writes.

The dropbox_uploader script is used to upload the files to Dropbox since there is currently no
Dropbox client for ARM. Hence, an Dropbox app is required that will receive the files. It will end up
in a path such as "Dropbox/Apps/<app_name>/<hostname>".

There will also be a cronjob installed that removes recordings after 7 days from the raspberry.

When an alarm is triggered an email will be sent (in this case using gmail through postfix) with an
snapshot from the recorded movie to the specified email address including recorded timestamp and 
from which host.

### Alarm Email Example
**Subject:** rpi_cam2: Motion detection<br>
**ALERT:** Motion detection(2017-08-24 07:56:08), CAMERA: rpi_cam2<br>
![Image Preview](https://github.com/lallassu/rpicam/blob/master/example.png)

## Prerequsities
* Raspberry PI2 with an camera attached to the camera slot.
* Host with ansible 1.2+ installed.
* Raspian installed on the memory card.
    * Download raspian lite image.
       https://downloads.raspberrypi.org/raspbian_lite_latest
    * Format the memory card with FAT32 filesystem.
    * Write the image to the card (see below)
* To make Dropbox upload work, create an application in Dropbox.
* Copy SSH key to the raspberry (default password is "raspberry" in the raspian image, please do change!) (see below)

### Commands
    # Write raspian image to disk
    $ sudo dd bs=1m if=<unzipped_image>.img of=/dev/<sd_card_disk> conv=sync
    # Copy ssh key
    $ ssh-copy-id pi@<ip>

## Configure
Configure all settings in *configure_me.yml*. This is the main configuration file for settings such as
email, dropbox upload etc.


## Usage
    ansible-playbook playbook.yml

The script will finish by rebooting the raspberry. The motion software will be running inside a
screen and you can watch the process with 'screen -r motion' logged in as user 'pi'.

You will also be able to live view the camera using the credentials you configured in *configure_me.yml*.

    http://<ip>:8080/

## NOTE
This has only been tested on Raspberry PI 3. Should be working with at least v2 as well (otherwise adjust RAM for tmpfs).
