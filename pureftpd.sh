apt install -y pure-ftpd-common pure-ftpd

ln -s /etc/pure-ftpd/conf/PureDB /etc/pure-ftpd/auth/50pure
echo no > /etc/pure-ftpd/conf/PAMAuthentication
echo no > /etc/pure-ftpd/conf/UnixAuthentication
echo "yes" > /etc/pure-ftpd/conf/CreateHomeDir
echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone
groupadd ftpusr
useradd -g ftpusr -d /dev/null -s /etc ftpusr
mkdir /home/ftp
pure-pw useradd zombie -u ftpusr -g ftpusr -d /home/ftp/zombie
pure-pw useradd ccstudio -u ftpusr -g ftpusr -d /media/hd2000/Manutencao
pure-pw mkdb

echo -e  '#!/bin/bash\nread -p "Enter UserName: " usrname\npure-pw useradd $usrname -u ftpusr -g ftpusr -d /home/FTP/$usrname && pure-pw mkdb'  > /usr/sbin/ftp-createacc
chmod u+x /usr/sbin/ftp-createacc

# force TLS
#echo 2 > /etc/pure-ftpd/conf/TLS

# insecure + TLS
echo 1 > /etc/pure-ftpd/conf/TLS
mkdir -p /etc/ssl/pure-ftpd
openssl req -x509 -nodes -days 730 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem
echo "2121" > /etc/pure-ftpd/conf/Bind
#echo "192.168.0.50,2121" > /etc/pure-ftpd/conf/Bind
systemctl restart pure-ftpd
echo "40110 42210" > /etc/pure-ftpd/conf/PassivePortRange
systemctl restart pure-ftpd
iptables -A INPUT -p tcp --dport 40110 --jump ACCEPT
iptables -A INPUT -p tcp --dport 42210 --jump ACCEPT
iptables-save
