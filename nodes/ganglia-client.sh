#! /bin/bash
cd
cd nodes
useradd -M ganglia
usermod -L ganglia
tar -zxf tars/ganglia-3.6.1.tar.gz
cd ganglia-3.6.1
./configure
make
make install
mkdir -p /var/lib/ganglia/rrds
chown -R ganglia:ganglia /var/lib/ganglia/rrds
mkdir /usr/local/etc/conf.d
cd ../
yes|cp configs/gmond.conf /usr/local/etc
yes|cp configs/gmond /etc/rc.d/init.d/
chmod -+x /etc/rc.d/init.d/gmond
chmod -+x /etc/rc.local
echo "gmond">>/etc/rc.local
service gmond start
