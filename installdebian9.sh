#INSTALL LINUX DEBIAN  WEBMIN APACHE MYSQL-SERVER PHPMYADMIN NMAP  HEXPARROT MINECRAFT 
#-----------------------------------------------------------------------------------------------------------------
#Original Distro MInecraft file Carlos Coelho 2017 - Zept3P -
#-----------------------------------------------------------------------------------------------------------------

#FIRST DEBIAN-WEB
#----------------------------------------

#Install debian netinstall

#addres to download ------>
#http://cdimage.debian.org/debian-cd/current/i386/iso-cd/debian-8.7.1-i386-netinst.iso
#http://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-8.7.1-amd64-netinst.iso

#echo SECOUND WEBMIN 
#-----------------------------------------

#in terminal server
#----------------------------------------------------------------------
apt-get update
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.850_all.deb
dpkg --install webmin_1.850_all.deb
# on error fault -> libraries -> 
# on port error /etc/init.d/webmin restart
# editing /etc/webmin/miniserv.conf port 10000 to 10222
apt-get install -f


#echo THIRDY PHP MYSQL APACHE NMAP SAMBA
#----------------------------------------------------------------------

apt-get update install
apt-get install apache2 -y
apt-get install php7.0 -y
apt-get install mysql-server
apt-get install phpmyadmin
apt-get install nmap -y
apt-get install samba -y
apt-get install iptraf-ng -y #  monitor lan
apt-get install install net-tools -y # case fault ifconfig
apt-get install testdisk  -y #  recover images
#echo FOUR MINECRAFT HEXPARROT
#------------------------------------------------------------------------------clear
#DNS NO-IP
#----------------------------------------------------------------------

cd /usr/local/src
wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
tar xzf noip-duc-linux.tar.gz
cd noip-2.1.9-1
make
#configure 
make install
#------------
#----------------------------------------------------------------------
#----------------------------------------------------------------------
#http://minecraft.codeemo.com/mineoswiki/index.php?title=MineOS-node_(apt-get)
#-----------------------------------------
apt-get update
# update repositories

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

#UTORRENT
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
wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb
dpkg -i libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb
utserver -settingspath /opt/utorrent-server-alpha-v3_3/ &
#--------------------------
#INIT AS SERVICE UTORRENT
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
#END INSTALl UTORRENT
#--------------------
# service utorrent stop
#---
#need remove 
#update-rc.d utorrent remove
#---
#------------------------
# IPTABLES RULES
#------------------------
# flush
iptables -L

# Teamspeak
iptables -A INPUT -p udp --dport 9987 -j ACCEPT
iptables -A INPUT -p udp --sport 9987 -j ACCEPT

iptables -A INPUT -p tcp --dport 30033 -j ACCEPT
iptables -A INPUT -p tcp --sport 30033 -j ACCEPT

iptables -A INPUT -p tcp --dport 10011 -j ACCEPT
iptables -A INPUT -p tcp --sport 10011 -j ACCEPT

# HTTP(s)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --sport 80 -j ACCEPT

iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp --sport 8080 -j ACCEPT

iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --sport 443 -j ACCEPT

# SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --sport 22 -j ACCEPT

# DNS
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT

# MINECRAFT
iptables -A INPUT -p udp --dport 25565 -j ACCEPT
iptables -A INPUT -p udp --sport 25565 -j ACCEPT
iptables -A INPUT -p udp --dport 25567 -j ACCEPT
iptables -A INPUT -p udp --sport 25567 -j ACCEPT

#SAVE
iptables-save > /etc/iptable-rules
#RESTORE
iptables-restore < /etc/iptable-rules


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
   echo END TEAMSPEAK3
#--------------------------
#Reboot to make sure it all works
## FINISH ALL INSTALED ##