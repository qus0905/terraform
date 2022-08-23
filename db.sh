#! /bin/bash
sudo su -
yum -y update
yum -y install http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sed -i '35d' /etc/yum.repos.d/mysql-community.repo 
sed -i '35i gpgcheck=0' /etc/yum.repos.d/mysql-community.repo 
 
yum install -y mysql-community-server
systemctl start mysqld
