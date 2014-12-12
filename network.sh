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
	else
		echo "$hwaddr
$uuid
NAME=$name
TYPE=Ethernet
BOOTPROTO=dhcp
ONBOOT=yes">/etc/sysconfig/network-scripts/$file
	fi
	(( c++ ))
done

echo 'DEVICE=bond0
IPADDR=11.0.0.1
NETMASK=255.255.255.0
ONBOOT=yes
BOOTPROTO=none
USERCTL=no
NM_CONTROLLED=no
BONDING_OPTS="mode=1 miimon=100 updelay=30000"'>/etc/sysconfig/network-scripts/ifcfg-bond0

service network restart;

nameserver=$(cat /etc/resolv.conf|grep nameserver)
echo "domain cluster.com
search cluster.com
nameserver 11.0.0.1
$nameserver">/etc/resolv.conf
chattr +i /etc/resolv.conf
ssh-keygen -N '' -f /root/.ssh/id_rsa
cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
ifconfig
