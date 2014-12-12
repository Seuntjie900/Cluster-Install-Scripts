#! /bin/bash


#basic install script for cluster nodes

./selinux.sh
./packages.sh
./network.sh
./ntp.sh
./ganglia-client.sh
./nfs.sh
cd /
cd
cd nodes
/root/nodes/./torque-client.sh

