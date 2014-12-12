#! /bin/bash
iptables -F
iptables -t nat -F
iptables -t mangle -F
service iptables save
service iptables restart
nics=$(ls /etc/sysconfig/network-scripts/|grep ifcfg)

echo "nics:"
for nic in $nics
do
echo ${nic:6}
done
read -p "Type name of nic for public network: " pub
echo "1">/proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o $pub -j MASQUERADE
service iptables save
service iptables restart
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
