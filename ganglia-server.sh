#! /bin/bash
cd
cd setup
useradd -M ganglia
usermod -L ganglia
tar -zxf tars/ganglia-3.6.1.tar.gz
cd ganglia-3.6.1

./configure --with-gmetad
make
make install
mkdir -p /var/lib/ganglia/rrds
chown -R ganliga:ganglia /var/lib/ganglia
mkdir /usr/local/etc/conf.d
cd
cd setup
yes|cp configs/gmetad.conf /usr/local/etc/gmetad.conf
yes|cp configs/gmond.conf /usr/local/etc/gmond.conf

yes|cp configs/gmetad /etc/rc.d/init.d/gmetad
yes|cp configs/gmond /etc/rc.d/init.d/gmond
chmod -+x /etc/rc.d/init.d/gmetad
chmod -+x /etc/rc.d/init.d/gmond
cd
cd setup
tar -zxf tars/ganglia-web-3.6.2.gz
mv ganglia-web-3.6.2/ /var/www/html/ganglia
chown -R root:root /var/www/html/ganglia/
cd /var/www/html/ganglia
cp /root/setup/configs/ganglia-web-Makefile Makefile
make install
chown -R ganglia:ganglia /var/lib/ganglia/rrds
chkconfig httpd on
service httpd start
#service gmetad start
#service gmond start
chkconfig gmond on
gmetad
service gmond start
echo "gmond
gmetad">>/etc/rc.d/rc.local
chmod -+x /etc/rc.local

