#!/bin/sh

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

apt-get install -y samba samba-common python-glade2 system-config-samba

mkdir -p /home/smbchakru
chown smbchakru /home/smbchakru

useradd smbchakru -d /home/smbchakru
passwd smbchakru
smbpasswd -a smbchakru

mkdir -p /home/sambashare
chown :sambashare /home/sambashare
chown smbchakru /home/sambashare
usermod -G sambashare smbchakru
chmod -R 775 /home/sambashare

cp /etc/samba/smb.conf /etc/samba/smb.conf.`date +"%Y%m%d%H%M"`

echo -e "[sambashare]\n\tcomment = Share Dir\n\tpath = /home/sambashare\n\tbrowseable = yes\n\tread only = no\n\tguest ok = no" | tee -a /etc/samba/smb.conf

systemctl restart nmbd
systemctl restart smbd
