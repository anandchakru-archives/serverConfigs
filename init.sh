#!/bin/sh

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

apt-get update
apt-get -y dist-upgrade

echo "HandleLidSwitch=ignore" | tee -a /etc/systemd/logind.conf
systemctl restart systemd-logind

