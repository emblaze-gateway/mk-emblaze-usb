#!/bin/bash

IMAGENAME=emblaze-usb.img
USBLABEL=EMBLAZE-USB
MOUNTPOINT=./img_mount_point
DATADIR=$1

if [ -e $MOUNTPOINT ]; then
    rm -r $MOUNTPOINT
fi

if [ -z $DATADIR ]; then
    DATADIR=./data
fi

set_default_config()
{
cat << EOF > $1/cmd.txt
# specific command

echo "Emblaze USB Command"
#sleep 10s
#reboot
#shutdown
#restart gateway
#restart ovpn
#restart all
EOF

cat << EOF > $1/run.txt
# emblaze-usb configuration file

wifi    # wifi set
cmd     # command
config  # emblaze-gateway config
#ovpn    # OpenVPN config
EOF

cat << EOF > $1/wifi.txt
# wifi information

disable      # enable or disable
#enable
#WIFI_SSID
#WIFI_PASSWORD
EOF

cp example.ini $1/config.ini
touch $1/ovpn.conf
}

if [ ! -e $DATADIR ]; then
    mkdir -p $DATADIR
    set_default_config $DATADIR
fi

dd if=/dev/zero of=$IMAGENAME bs=1M count=0 seek=40

mkfs.fat -F 32 -n $USBLABEL -v $IMAGENAME

finish()
{
    sudo umount $MOUNTPOINT || true
    echo -e "\e[31m Fail making EMBLAZE-USB\e[0m"
    exit -1
}

echo "mkdir mountpoint"
mkdir -p $MOUNTPOINT
echo "mount"
sudo mount $IMAGENAME $MOUNTPOINT
trap finish ERR

echo "copy"
sudo cp $DATADIR/* $MOUNTPOINT

echo "umount"
sudo umount $MOUNTPOINT

echo "Success making EMBLAZE-USB"
