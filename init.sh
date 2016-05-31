#!/bin/sh

sudo apt-get update
sudo apt-get -y dist-upgrade

sudo echo "HandleLidSwitch=ignore" | tee -a /etc/systemd/logind.conf


