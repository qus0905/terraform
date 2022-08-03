#! /bin/bash
sudo su -
yum -y update
yum install -y httpd httpd-devel gcc gcc-c++
wget https://dlcdn.apache.org/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.48-src.tar.gz 
tar xvfz tomcat-connectors-1.2.48-src.tar.gz
cd tomcat-connectors-1.2.48-src/native/
./configure --with-apxs=/bin/apxs
make && make install

cd apache-2.0/
\cp -f mod_jk.so /usr/lib64/httpd/modules/mod_jk.so
chmod 755 /usr/lib64/httpd/modules/mod_jk.so 

sed -i '58i LoadModule jk_module /usr/lib64/httpd/modules/mod_jk.so' /etc/httpd/conf/httpd.conf
sed -i '59i <IfModule jk_module>' /etc/httpd/conf/httpd.conf
sed -i '60i  JkWorkersFile /etc/httpd/conf/workers.properties' /etc/httpd/conf/httpd.conf
sed -i '61i  JkLogFile /var/log/httpd/mod_jk.log' /etc/httpd/conf/httpd.conf
sed -i '62i JkShmFile run/mod_jk.shm' /etc/httpd/conf/httpd.conf
sed -i '63i JkLogLevel info' /etc/httpd/conf/httpd.conf
sed -i '64i JkLogStampFormat "[%a %b $d %H:%M:%S %Y]" ' /etc/httpd/conf/httpd.conf
sed -i '65i JkMount /*.jsp worker1' /etc/httpd/conf/httpd.conf
sed -i '66i  </IfModule>' /etc/httpd/conf/httpd.conf


cat> /etc/httpd/conf/workers.properties << EOF
worker.list=worker1
worker.worker1.type=ajp13
worker.worker1.host= 12.0.2.10
worker.worker1.port=8009
worker.worker1.lbfactor=1
EOF

systemctl start httpd
systemctl enable httpd

cd~
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y install http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sed -i '35d' /etc/yum.repos.d/mysql-community.repo 
sed -i '35i gpgcheck=0' /etc/yum.repos.d/mysql-community.repo 
yum install -y mysql-community-client

mysql -uadmin -p -h tf-db.chuu6jshlzzt.ap-northeast-2.rds.amazonaws.com
It12345!

use BBS;
