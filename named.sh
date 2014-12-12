#! /bin/bash

service named start
echo "## Waiting for named service first time run##"
sleep 30 
rndckey=$(cat /etc/rndc.key)

echo "//
// named.conf
//
// Provided by Red Hat bind package to configure the ISC BIND named(8) DNS
// server as a caching only nameserver (as a localhost DNS resolver only).
//
// See /usr/share/doc/bind*/sample/ for example named configuration files.
//

options {
        listen-on port 53 { 127.0.0.1; 11.0.0.1;};
        listen-on-v6 port 53 { ::1; };
        directory       \"/var/named\";
        dump-file       \"/var/named/data/cache_dump.db\";
        statistics-file \"/var/named/data/named_stats.txt\";
        memstatistics-file \"/var/named/data/named_mem_stats.txt\";
        allow-query     { localhost; 11.0.0.0/24;};
        recursion yes;

        dnssec-enable yes;
        dnssec-validation yes;
        dnssec-lookaside auto;

        /* Path to ISC DLV key */
        bindkeys-file \"/etc/named.iscdlv.key\";

        managed-keys-directory \"/var/named/dynamic\";
};

$rndckey
zone \".\" IN {
        type hint;
        file \"named.ca\";
};

zone \"cluster.com\" IN {
        type master;
        file \"/etc/named/cluster.com\";
        allow-update { key rndc-key;};
};

zone \"0.0.11.rev.in-addr.arpa\" in {
        type master;
        file \"/etc/named/rev.cluster.com\";
        allow-update { key rndc-key;};
};
include \"/etc/named.rfc1912.zones\";
include \"/etc/named.root.key\";
">/etc/named.conf

echo "\$TTL 86400
@ IN SOA  master.cluster.com. root.cluster.com. (
                                57         ; serial
                                604800     ; refresh (1 week)
                                86400      ; retry (1 day)
                                2419200    ; expire (4 weeks)
                                86400      ; minimum (1 day)
                                )
@ IN NS master.cluster.com.
master IN A  11.0.0.1
">/etc/named/cluster.com

echo "\$TTL 86400
@ IN SOA  master.cluster.com. root.cluster.com. (
                                57         ; serial
                                604800     ; refresh (1 week)
                                86400      ; retry (1 day)
                                2419200    ; expire (4 weeks)
                                86400      ; minimum (1 day)
                                )
@ IN NS master.cluster.com.
master IN A  11.0.0.1
1 IN PTR master.cluster.com
">/etc/named/rev.cluster.com
chown -R root:named /etc/named
chmod -R 774 /etc/named
iptables -t filter -p udp -m state --state NEW --dport 53 -j ACCEPT
iptables -t filter -p tcp -m state --state NEW --dport 53 -j ACCEPT
service iptables save
service iptables restart
service named restart
chkconfig named on

