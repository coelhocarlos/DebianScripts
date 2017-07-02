#INSTALL LINUX DEBIAN  WEBMIN APACHE MYSQL-SERVER PHPMYADMIN NMAP  MINECRAFT 
-----------------------------------------------------------------------------------------------------------------
#Original Distro MInecraft file Carlos Coelho 2017 - Zer0
-----------------------------------------------------------------------------------------------------------------

#FIRST DEBIAN-WEB
----------------------------------------

#Install debian netinstall

#addres to download ------>
#http://cdimage.debian.org/debian-cd/current/i386/iso-cd/debian-8.7.1-i386-netinst.iso
#http://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-8.7.1-amd64-netinst.iso

#SECOUND WEBMIN 
-----------------------------------------

in terminal server
apt-get update
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.831_all.deb
dpkg --install webmin_1.831_all.deb
on error fault -> libraries ->
apt-get install -f

#THIRDY PHP MYSQL APACHE NMAP SAMBA
-----------------------------------

apt-get update install
apt-get install apache2
apt-get install php7.0
apt-get install mysql-server
apt-get install phpmyadmin
apt-get install nmap
apt-get install samba

#FOUR MINECRAFT HEXPARROT
-----------------------------------------
#http://minecraft.codeemo.com/mineoswiki/index.php?title=MineOS-node_(apt-get)
-----------------------------------------
apt-get update
# update repositories

apt-get install curl
curl -sL https://deb.nodesource.com/setup_4.x | bash -
apt-get update

# download the necessary prerequisite components for mineos
apt-get -y install nodejs supervisor git rdiff-backup screen build-essential openjdk-7-jre-headless

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
-------------------------------
apt-get update
mkdir downloads
cd dowbloads
http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-debian-7-0
mv linux-x64-debian-7-0 linux-x64-debian-7-0.tar.gz
tar -zxvf linux-x64-debian-7-0.tar.gz -C /opt/
chown root:root -R /opt/utorrent-server-alpha-v3_3/
ln -s /opt/utorrent-server-alpha-v3_3/utserver /usr/bin/utserver
apt-get install libssl1.0.0 libssl-dev
for debian stretch
$ wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb
# dpkg -i libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb
utserver -settingspath /opt/utorrent-server-alpha-v3_3/ &
--------------------------
#INIT AS SERVICE UTORRENT
--------------------

wget https://pastebin.com/raw/GZwVSH6D
chmod 755 utorrent
cp utorrent /etc/init.d/
cd /etc/init.d/
update-rc.d utorrent defaults
service utorrent start
systemctl status utorrent.service
service utorrent restart
service utorrent stop
---
#need remove 
#update-rc.d utorrent remove
---
#Reboot to make sure it all works
## FINISH ALL INSTALED ##
