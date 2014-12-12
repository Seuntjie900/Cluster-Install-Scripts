#! /bin/bash

files=$(ls /etc/sysconfig/network-scripts/ | grep  ifcfg-)
c=1
for file in $files
do
        echo $file
        hwaddr=$(cat /etc/sysconfig/network-scripts/$file|grep HWADDR)
        uuid=$(cat /etc/sysconfig/network-scripts/$file|grep UUID)
        name=${file:6}
        if [ $c -lt 3 ]
        then
                echo "$hwaddr
$uuid
NAME=$name
TYPE=Ethernet
BOOTPROTO=none
ONBOOT=yes
MASTER=bond0
SLAVE=yes
NM_CONTROLLED=no">/etc/sysconfig/network-scripts/$file
 fi
        (( c++ ))
done

echo 'DEVICE=bond0
ONBOOT=yes
BOOTPROTO=dhcp
USERCTL=no
NM_CONTROLLED=no
BONDING_OPTS="mode=1 miimon=100 updelay=30000"'>/etc/sysconfig/network-scripts/ifcfg-bond0

echo "send fqdn.fqdn \"$(hostname)\";
send fqdn.encoded on;
send fqdn.server-update off;
also request fqdn;">/etc/dhcp/dhclient-bond0.conf
service network restart;


