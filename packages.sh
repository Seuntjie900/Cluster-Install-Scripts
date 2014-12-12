#! /bin/bash
#############################
#Disable firewalld
#######################
systemctl stop firewalld
systemctl mask firewalld

#############################
#install packages
#######################
cd
cd setup/rpms
rpm -Uvh *.rpm
cd

#############################
#Enable iptables
#######################
systemctl enable iptables

