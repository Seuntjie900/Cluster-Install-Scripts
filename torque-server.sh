#! /bin/bash

tar -zxf tars/torque-4.2.8.tar.gz
cd torque-4.2.8
./configure
make
make install
cp contrib/init.d/pbs_server /etc/init.d/
cp contrib/init.d/pbs_sched /etc/init.d/
cp contrib/init.d/trqauthd /etc/init.d
chmod -+x /etc/init.d/pbs_server
chmod -+x /etc/init.d/pbs_sched
chmod -+x /etc/init.d/trqauthd
chkconfig trqauthd on
chkconfig pbs_server on
chkconfig pbs_sched on

service trqauthd start
#service pbs_server start
#service pbs_sched start

echo "master.cluster.com">/var/spool/torque/server_name
echo 'usr/local/lib'>/etc/ld.so.conf.d/torque.conf
ldconfig
./torque.setup root master.cluster.com
echo "node01.cluster.com np=12 prod
node02.cluster.com np=12 prod
node03.cluster.com np=12 prod">/var/spool/torque/server_priv/nodes
service pbs_server restart
service pbs_sched start
make packages
iptables -A INPUT -s 11.0.0.0/24 -p udp -j ACCEPT
iptables -A INPUT -s 11.0.0.0/24 -p tcp -j ACCEPT
iptables -A OUTPUT -s 11.0.0.0/24 -p tcp -j ACCEPT
iptables -A OUTPUT -s 11.0.0.0/24 -p udp -j ACCEPT
service iptables save
service iptables restart
service pbs_server restart
