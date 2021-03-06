apt install -y pure-ftpd-common pure-ftpd

ln -s /etc/pure-ftpd/conf/PureDB /etc/pure-ftpd/auth/50pure
echo no > /etc/pure-ftpd/conf/PAMAuthentication
echo no > /etc/pure-ftpd/conf/UnixAuthentication
echo "yes" > /etc/pure-ftpd/conf/CreateHomeDir
echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone

groupadd FTPUSR
useradd -g FTPUSR -d /dev/null -s /etc FTPUSR

useradd -d /home/zombie/Server/public_ftp -s /sbin/nologin ftp
mkdir /home/zombie/Server/public_ftp

pure-pw useradd ccstudio -u FTPUSR -g FTPUSR -d /home/zombie/Server/ccstudio_ftp
mkdir /home/zombie/Server/ccstudio_ftp

pure-pw mkdb

#echo -e  '#!/bin/bash\nread -p "Enter UserName: " usrname\npure-pw useradd $usrname -u ftpusr -g ftpusr -d /home/zombie/ccstudio_ftp/$usrname && pure-pw mkdb'  > /usr/sbin/ftp-createacc
#chmod u+x /usr/sbin/ftp-createacc
#pure-pw userdel joe
# force TLS
#echo 2 > /etc/pure-ftpd/conf/TLS

# insecure + TLS
echo 1 > /etc/pure-ftpd/conf/TLS
mkdir -p /etc/ssl/pure-ftpd
openssl req -x509 -nodes -days 730 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem
echo "2121" > /etc/pure-ftpd/conf/Bind
echo "40110 42210" > /etc/pure-ftpd/conf/PassivePortRange
#echo "192.168.0.50,2121" > /etc/pure-ftpd/conf/Bind
systemctl restart pure-ftpd

iptables -A INPUT -p tcp --dport 40110 --jump ACCEPT
iptables -A INPUT -p tcp --dport 42210 --jump ACCEPT
iptables-save > /etc/webmin/firewall/iptables-save
iptables-restore < /etc/webmin/firewall/iptables-save
