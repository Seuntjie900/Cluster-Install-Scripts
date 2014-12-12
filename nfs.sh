#! /bin/bash
mkdir /exports
echo "/root 11.0.0.0/24(rw,async,no_root_squash)
/home 11.0.0.0/24(rw,async,no_root_squash)
/exports 11.0.0.0/24(rw,async,no_root_squash)">/etc/exports
exportfs -va
chkconfig rpcbind on
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
service rpcbind start
service nfs restart
