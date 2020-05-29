#!/bin/bash
set -e

#
# anind dependencies
# source https://github.com/anbox/anbox-modules
sudo apt-get update && sudo apt-get -y upgrade
sudo apt install -y dkms unzip

curl -OL https://github.com/anbox/anbox-modules/archive/master.zip
unzip -o master.zip
rm master.zip

sudo cp ./anbox-modules-master/anbox.conf /etc/modules-load.d/
sudo cp ./anbox-modules-master/99-anbox.rules /lib/udev/rules.d/

sudo cp -rT ./anbox-modules-master/ashmem /usr/src/anbox-ashmem-1
sudo cp -rT ./anbox-modules-master/binder /usr/src/anbox-binder-1

sudo dkms install anbox-ashmem/1
sudo dkms install anbox-binder/1

# assert
sudo modprobe binder_linux
sudo modprobe binder_linux

#
# Docker
sudo apt-get install -y docker.io