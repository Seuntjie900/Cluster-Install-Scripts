#! /bin/bash
./selinux.sh
./packages.sh
./network.sh
./named.sh
./dhcp.sh
./nat.sh
./nfs.sh
./ntp.sh
./ganglia-server.sh
./torque-server.sh
tar -zxf benchmarks.tar.gz
mv benchmarks ../
service named stop
service named start
service dhcpd stop
service dhcpd start
service rpcbind stop
service rpcbind start
service nfs stop
service nfs start
service ntpd stop
service ntpd start
service gmond restart
service pbs_server restart
