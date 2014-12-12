#! /bin/bash

#####################
#NTP
##############

cp configs/ntp.conf /etc/ntp/conf
chkconfig ntpd on
service ntpd start


