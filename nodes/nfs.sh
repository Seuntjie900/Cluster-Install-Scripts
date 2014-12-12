!# /bin/bash

mkdir /exports
service nfs start
echo "master:/root            /root                   nfs     nfsvers=3,nolock 0 0
master:/home            /home                   nfs     nfsvers=3,nolock 0 0
master:/exports         /exports                nfs     nfsvers=3,nolock 0 0
">>/etc/fstab

mount -a
