#!/bin/bash
systemctl stop firewalld
systemctl disable firewalld
setenforce 0
#如果本地没有mysql源
#cd /usr/src
#wget https://downloads.mysql.com/archives/get/file/mysql-5.7.22-linux-glibc2.12-x86_64.tar.gz
tar -xf /usr/src/mysql-5.7.22-linux-glibc2.12-x86_64.tar.gz -C /usr/local
groupadd -r mysql
useradd -M -s /sbin/nologin -g mysql mysql
cd /usr/local/
ln -sv mysql-5.7.22-linux-glibc2.12-x86_64/ mysql
chown -R mysql.mysql /usr/local/mysql
cd /etc/profile.d/
echo -r 'export PATH=/usr/local/mysql/bin:$PATH' >> mysql.sh
bash /ect/profile.d/mysql.sh
mkdir /opt/data
chown -R mysql.mysql /opt/data
cd /root
/usr/local/mysql/bin/mysqld --initialize --user=mysql --datadir=/opt/data/ >> init_mysql
cat >/etc/my.cnf<<EFO
[mysqld]
basedir = /usr/local/mysql
datadir = /opt/data
socket = /tmp/mysql.sock
port = 3306
pid-file = /opt/data/mysql.pid
user = mysql
skip-name-resolve
EFO
cp -a /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
sed -ri 's#^(basedir=).*#\1/usr/local/mysql#g' /etc/init.d/mysqld
sed -ri 's#^(datadir=).*#\1/opt/data#g' /etc/init.d/mysqld
/etc/init.d/mysqld start

