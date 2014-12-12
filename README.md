Cluster-Install-Scripts
=======================

Basic installation scripts for a cluster

Currently requires centos 7. Hostnames are set up as master.cluster.com and nodexx.cluster.com
Most values are hardcoded. Chances are good that it's going to fuck up the network initially.

On master, extract/copy to /root/setup, then run  /root/setup/install.sh.
copy nodes folder from /root/setup/nodes to /root/setup
Copy nodes folder onto nodes into /root/nodes then run /root/nodes/install.sh on each node
