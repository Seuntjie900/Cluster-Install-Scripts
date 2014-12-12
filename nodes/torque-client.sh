#! /bin/bash

cd
cd setup/torque-4.2.8
./torque-package-mom-linux-x86_64.sh --install
./torque-package-clients-linux-x86_64.sh --install
echo '/usr/local/lib'>/etc/ld.so.conf.d/torque.conf
ldconfig
cp contrib/init.d/pbs_mom /etc/init.d/
cp contrib/init.d/trqauthd /etc/init.d/
chmod -+x /etc/init.d/pbs_mom
chmod -+x /etc/init.d/trqauthd
chkconfig trqauthd on
chkconfig pbs_mom on
service trqauthd start
#service pbs_mom start
echo '$pbsserver master
$logevent 225
$usercp *:/home /home'>/var/spool/torque/mom_priv/config
service pbs_mom start
iptables -A INPUT -s 11.0.0.0/24 -p udp -j ACCEPT
iptables -A INPUT -s 11.0.0.0/24 -p tcp -j ACCEPT
iptables -A OUTPUT -s 11.0.0.0/24 -p tcp -j ACCEPT
iptables -A OUTPUT -s 11.0.0.0/24 -p udp -j ACCEPT
service iptables save
service iptables restart


