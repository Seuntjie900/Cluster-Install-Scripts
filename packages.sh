#! /bin/bash
#############################
#Disable firewalld
#######################
systemctl stop firewalld
systemctl mask firewalld

#############################
#install packages
#######################
#cd
#cd setup/rpms
#rpm -Uvh *.rpm
#cd
yum install wget -y
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
rpm -ivh epel-release-7-2.noarch.rpm
yum install -y gcc* openssh* nfs-utils named dhcp zlib-devel vim ntp make glibc libgfortran flex boost cmake mpfr-devel mpfr apr-devel rrdtool-devel pcre-devel expat-devel httpd rsync php openssh-devel libxml2-devel xauth xeyes xclock gedit dbus-x11 firefox libconfuse-devel

#############################
#Enable iptables
#######################
systemctl enable iptables

