#! /bin/bash
rndckey=$(cat /etc/rndc.key)
echo "#
# DHCP Server Configuration file.
#   see /usr/share/doc/dhcp*/dhcpd.conf.sample
#   see 'man 5 dhcpd.conf'

$rndckey

zone cluster.com. {
primary 127.0.0.1;
key rndc-key;
}

zone 0.0.11.in-addr.arpa. {
primary 127.0.0.1;
key rndc-key;
}

ddns-update-style interim;
authoritive;
ddns-domainname \"cluster.com\";
ddns-updates on;
option domain-name-servers 11.0.0.1, 10.0.0.2;
option domain-name \"cluster.com\";

subnet 11.0.0.0 netmask 255.255.255.0 {
        option routers 11.0.0.1;
        option subnet-mask 255.255.255.0;
        option time-offset 126000;
        range 11.0.0.1 11.0.0.254;
        ignore client-updates;
}">/etc/dhcp/dhcpd.conf
service dhcpd start
chkconfig dhcpd on
