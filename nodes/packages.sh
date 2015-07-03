#! /bin/bash
#############################
#Disable firewalld
#######################
systemctl stop firewalld
systemctl mask firewalld

#############################
#install packages
#######################

cd rpms
rpm -Uvh *

#############################
#Enable iptables
#######################
systemctl enable iptables
modprobe --first-time bonding
