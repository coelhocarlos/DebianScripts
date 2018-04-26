#INSTALL LINUX DEBIAN  WEBMIN APACHE PHP 7.1 MYSQL-SERVER PHPMYADMIN NMAP  HEXPARROT MINECRAFT MINEOS
#-----------------------------------------------------------------------------------------------------------------
#Original Distro MInecraft file Carlos Coelho 2017 - Zept3P -
#-----------------------------------------------------------------------------------------------------------------

#FIRST DEBIAN-WEB
#----------------------------------------

#Install debian netinstall

#addres to download ------>
#http://cdimage.debian.org/debian-cd/current/i386/iso-cd/debian-8.7.1-i386-netinst.iso
#http://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-8.7.1-amd64-netinst.iso
apt-get update && apt-get -y upgrade &&  apt-get -y dist-upgrade
#
echo install WEBMIN 
#-----------------------------------------

#in terminal server
#----------------------------------------------------------------------
apt-get update
wget https://prdownloads.sourceforge.net/webadmin/webmin_1.881_all.deb
dpkg --install webmin_1.881_all.deb
# on error fault -> libraries -> 
apt-get install -f
# on port error /etc/init.d/webmin restart
# editing /etc/webmin/miniserv.conf port 10000 to 10222



echo THIRDY PHP MYSQL APACHE NMAP SAMBA
#----------------------------------------------------------------------



apt-get install mysql-server
mysql_secure_installation
apt-get install apache2 -y
systemctl restart apache2
apt-get install php7.2 -y
apt-get install libapache2-mod-php7.2 php7.2-mcrypt php7.2-mysql
php7-xdebug -y
apt-get install phpmyadmin
apt-get install nmap -y
apt-get install samba -y
apt-get install net-tools -y
#  monitor lan
apt-get install iptraf-ng -y 
# case fault ifconfig
apt-get install install net-tools -y 
#  recover images
apt-get install testdisk  -y 
# monitor your Server ---  Start $glances
apt-get install glances -y 
# git
apt-get install git bc -y
#mount
mkdir /media/hd160
mkdir /media/hd320
mkdir /media/hd2000
mount -t ntfs-3g /dev/sdb1 /media/hd160
mount -t ntfs-3g /dev/sdc1 /media/hd320
mount -t ntfs-3g /dev/sdd1 /media/hd2000
# tftp PXE
apt-get install tftpd-hpa
#nano /etc/default/tftpd-hpa
cd /etc/default/
wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/tftpd-hpa
/etc/init.d/tftpd-hpa restart
cd 
apt-get install isc-dhcp-server
cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.old
cd /etc/dhcp/
wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/dhcpd.conf
cd 
service isc-dhcp-server restart
apt-get install dnsmasq
cd /etc/
wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/dnsmasq.conf
/etc/init.d/dnsmasq restart
cd 
cd /etc/network/
wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/interfaces
#/etc/init.d/networking restart
cd 
apt-get install genisoimage 
apt-get install wimtools 
apt-get install cabextract
ln -s /usr/bin/genisoimage /usr/bin/mkisofs
#-----------------------------------------------------------------------
echo START  VAR/WWW modify to your user
#-----------------------------------------------------------------------
cd /var/www
chown www-data:www-data -R *
chown root:root -R *
chown zombie:zombie -R *
/etc/init.d/apache2 restart
#-----------------------------------------------------------------------
echo INSTALL  DNS NO-IP START
#----------------------------------------------------------------------

cd /usr/local/src
wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
tar xzf noip-duc-linux.tar.gz
cd noip-2.1.9-1
make
#configure 
make install
#
#----------------------------------------------------------------------
#----------------------------------------------------------------------
#http://minecraft.codeemo.com/mineoswiki/index.php?title=MineOS-node_(apt-get)
#-----------------------------------------
apt-get update
# update repositories
# change port nano /etc/webmin/miniserv.conf
apt-get install curl
curl -sL https://deb.nodesource.com/setup_4.x | bash -
apt-get update

# download the necessary prerequisite components for mineos
apt-get -y install nodejs supervisor git rdiff-backup screen build-essential openjdk-8-jre-headless

# download the most recent mineos web-ui files from github
mkdir -p /usr/games
cd /usr/games
git clone https://github.com/hexparrot/mineos-node.git minecraft
cd minecraft
git config core.filemode false
chmod +x service.js mineos_console.js generate-sslcert.sh webui.js
ln -s /usr/games/minecraft/mineos_console.js /usr/local/bin/mineos
cp mineos.conf /etc/mineos.conf
npm install

# distribute service related files
cp init/supervisor_conf /etc/supervisor/conf.d/mineos.conf

# generate self-signed certificate
./generate-sslcert.sh

# start the background service
supervisorctl reload
#supervisorctl start mineos
#supervisorctl stop mineos


echo START INSTALL UTORRENT
#-------------------------------
apt-get update
mkdir downloads
cd downloads
wget http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-debian-7-0
mv linux-x64-debian-7-0 linux-x64-debian-7-0.tar.gz
tar -zxvf linux-x64-debian-7-0.tar.gz -C /opt/
chown root:root -R /opt/utorrent-server-alpha-v3_3/
ln -s /opt/utorrent-server-alpha-v3_3/utserver /usr/bin/utserver
# apt-get install libssl1.0.0 libssl-dev original squeze
# for debian stretch
apt-get install gdebi -y
wget  http://ftp.psu.ru/linux/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb
wget  http://mirrors.kernel.org/ubuntu/pool/main/o/openssl/libssl1.0.0_1.0.2g-1ubuntu4.12_amd64.deb
apt install gdebi dirmngr
gdebi libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb
dpkg -i libssl-dev_1.0.1t-1+deb8u6_amd64.deb
dpkg -i libssl1.0.0_1.0.2g-1ubuntu4.1_amd64.deb
utserver -settingspath /opt/utorrent-server-alpha-v3_3/ &
#--------------------------
echo INIT AS SERVICE UTORRENT
#--------------------

wget https://raw.githubusercontent.com/coelhocarlos/debian9-install/master/utorrent
chmod 755 utorrent
cp utorrent /etc/init.d/
cd /etc/init.d/
update-rc.d utorrent defaults
service utorrent start
#systemctl status utorrent.service
service utorrent restart

#--------------------------
echo END INSTALL UTORRENT
#--------------------
# service utorrent stop
#---
#need remove 
#update-rc.d utorrent remove
#---
#------------------------
echo  IPTABLES RULES
#------------------------
#-----Allow Established and Related Incoming Connections
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -i enp1s0 -j ACCEPT
iptables -A OUTPUT -o enp1s0 -j ACCEPT
#-----Allow Established Outgoing Connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
#-----Internal to External
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT 
#-----Drop Invalid Packets
#iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
#----Block an IP Address
#iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
#----Block a invalid Packets
#iptables -A INPUT -s 15.15.15.51 -j DROP
#----Reject Network Ip
#iptables -A INPUT -s 15.15.15.51 -j REJECT
#----Reject Network Interfaces
#iptables -A INPUT -i eth0 -s 15.15.15.51 -j DROP
#----Allow All Incoming SSH 
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -s 15.15.15.0/24 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
#----Allow Outgoing SSH
iptables -A OUTPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
#----Allow All Incoming HTTP
iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 80 -m conntrack --ctstate ESTABLISHED -j ACCEPT
#----Allow All Incoming HTTPS
iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 443 -m conntrack --ctstate ESTABLISHED -j ACCEPT
#----Allow All Incoming HTTP and HTTPS
iptables -A INPUT -p tcp -m multiport --dports 80,443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m conntrack --ctstate ESTABLISHED -j ACCEPT
#----Allow All Incoming FTP
iptables -A INPUT -p tcp --dport 21-m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 21-m conntrack --ctstate ESTABLISHED -j ACCEPT
#----Allow MySQL from Specific IP Address or Subnet
iptables -A INPUT -p tcp -s 15.15.15.0/24 --dport 3306 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 3306 -m conntrack --ctstate ESTABLISHED -j ACCEPT
#----Allow Email  
iptables -A INPUT -p tcp --dport 25 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 25 -m conntrack --ctstate ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --dport 143 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 143 -m conntrack --ctstate ESTABLISHED -j ACCEPT
#---Allow Eamail SMTP 
iptables -A INPUT -p tcp --dport 143 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 143 -m conntrack --ctstate ESTABLISHED -j ACCEPT
#---Allow Eamail IMAP
iptables -A INPUT -p tcp --dport 993 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 993 -m conntrack --ctstate ESTABLISHED -j ACCEPT
#---Allow All Incoming POP3
iptables -A INPUT -p tcp --dport 110 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 110 -m conntrack --ctstate ESTABLISHED -j ACCEPT
#---Allow All Incoming POP3S
iptables -A INPUT -p tcp --dport 995 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 995 -m conntrack --ctstate ESTABLISHED -j ACCEPT
#---Allow All TEAMSPEAK3
iptables -A INPUT -p tcp --dport 10011 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 10011 -m conntrack --ctstate ESTABLISHED -j ACCEPT

iptables -A INPUT -p tcp -m tcp --dport 10000 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 11100 -j ACCEPT

iptables -A INPUT -p tcp --dport 30033 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 30033 -m conntrack --ctstate ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp --dport  9987 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p udp --sport  9987 -m conntrack --ctstate ESTABLISHED -j ACCEPT
#---Allow All MINECRAFT
iptables -A INPUT -p tcp --dport 25565 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 25565 -m conntrack --ctstate ESTABLISHED -j ACCEPT
#--Allow All PXE
iptables -A INPUT -p ALL -i $INET_IFACE -s 192.168.0.0/24 -j ACCEPT
iptables -A INPUT -p ALL -i $INET_IFACE -d 192.168.0.255 -j ACCEPT
iptables -A udp_inbound -p UDP -s 0/0 --destination-port 69 -j ACCEPT
#--Allow All QUAKE
iptables -A INPUT -p udp -m udp --dport 27910:27912 -j ACCEPT
#--Allow All CSTRIKE
iptables -A INPUT -p udp -m udp --dport 27915:27917 -j ACCEPT
#----SAVE
iptables-save > /etc/iptables.up.rules
#----RESTORE
iptables-restore < /etc/iptables.up.rules
#---FLUSH
iptables -F
#---FINISH IPTABLES


#--------------------------
   echo TEAMSPEAK3 SERVER
#--------------------------
	
wget http://ftp.4players.de/pub/hosted/ts3/releases/3.0.10.3/teamspeak3-server_linux-amd64-3.0.10.3.tar.gz
tar xzf teamspeak3-server_linux-amd64-3.0.10.3.tar.gz
adduser --disabled-login teamspeak3
mv teamspeak3-server_linux-amd64 /usr/local/teamspeak3
chown -R teamspeak3 /usr/local/teamspeak3
ln -s /usr/local/teamspeak3/ts3server_startscript.sh /etc/init.d/teamspeak3
update-rc.d teamspeak3 defaults
service teamspeak3 start

#---------------------------
   echo END TEAMSPEAK
#--------------------------
#---------------------------
   echo letsencrypt
#--------------------------

#cd downloads
git clone https://github.com/letsencrypt/letsencrypt
./letsencrypt-auto certonly --standalone --email saheetha1@gmail.com --agree-tos -d nodenixbox.com

#---------------------------
   echo END letsencrypt
#--------------------------
#---------------------------
   echo Netdata INSTALL
#--------------------------
apt-get install uuid-dev
curl -Ss 'https://raw.githubusercontent.com/firehol/netdata-demo-site/master/install-required-packages.sh' >/tmp/kickstart.sh && bash /tmp/kickstart.sh -i netdata-all
apt-get install zlib1g-dev uuid-dev libmnl-dev gcc make git autoconf autoconf-archive autogen automake pkg-config curl
git clone https://github.com/firehol/netdata.git --depth=1
cd netdata
./netdata-installer.sh
# stop netdata
killall netdata
# copy netdata.service to systemd
cp system/netdata.service /etc/systemd/system/
# let systemd know there is a new service
systemctl daemon-reload
# enable netdata at boot
systemctl enable netdata
# start netdata
systemctl start netdata
#---------------------------
   echo Netdata END
#--------------------------

#------------------------------------------------------------------
#Iecho INSTALL MEGATools
#--------------------------------------------------------------------
apt-get -y install build-essential libglib2.0-dev libssl-dev \ libcurl4-openssl-dev libgirepository1.0-dev
cd
mkdir ~/.scripts
cd ~/.scripts
wget https://raw.githubusercontent.com/coelhocarlos/meganz/master/megasend.sh
wget https://raw.githubusercontent.com/coelhocarlos/sqldump/master/MysqlDump.sh
chmod +x megasend.sh
chmod +x MysqlDump.sh
cd 
mkdir downloads 
cd downloads 
wget http://ftp.br.debian.org/debian/pool/main/m/megatools/megatools_1.9.98-1_amd64.deb
dpkg -i megatools_1.9.98-1_amd64.deb
cd 
cp ~/.megarc
nano ~/.megarc
#----------------------------------
#[Login]
#Username = 
#Password = 
#-----------------------------------

#-----------------------HOW TO USE -------------------------------------------------------------
#megareg –  Registrar-se e verificar uma conta nova mega.
#megadf –  Mostre seu espaço de armazenamento em nuvem uso / quota.
#megals –  Listar todos os arquivos remotos.
#megamkdir –  Criar diretório remoto.
#megarm –  Remover arquivo ou diretório remoto.
#megaput –  Upload de arquivos individuais.
#megaget –  Baixe arquivos individuais.
#megadl –  ficheiro para download a partir do link “público” Mega (não requer login).
#megastream –  Download Transmissão MegaStream de um arquivo (pode ser usado para ver os vídeos ou música).
#megasync –  Upload ou download de uma árvore de diretórios.

#Reboot to make sure it all works
## FINISH ALL INSTALED ##

/etc/init.d/networking restart
