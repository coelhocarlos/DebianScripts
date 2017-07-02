#!/bin/sh
apt-get update
apt-get dist-upgrade
mkdir downloads
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.850_all.deb
apt-get install -f
echo WEBMIN INSTALADO COM SUCESSO ----
echo.
echo..
echo...
echo INSTALANDO WEB APPS
apt-get update  install
apt-get install apache2 
apt-get install php7.0 
apt-get install mysql-server 
apt-get install phpmyadmin 
apt-get install nmap 
apt-get install samba 
echo INSTALANDO MINECRAFT 
# update repositories
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
echo MINECRAFT INSTALADO COM SUCESSO 
echo.
echo..
echo...
echo INSTALANDO UTORRENT
apt-get update
mkdir downloads
cd downloads
wgte http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-debian-7-0
mv linux-x64-debian-7-0 linux-x64-debian-7-0.tar.gz
tar -zxvf linux-x64-debian-7-0.tar.gz -C /opt/
chown root:root -R /opt/utorrent-server-alpha-v3_3/
ln -s /opt/utorrent-server-alpha-v3_3/utserver /usr/bin/utserver
apt-get install libssl1.0.0 libssl-dev
for debian stretch
wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb
dpkg -i libssl1.0.0_1.0.1t-1+deb8u6_amd64.deb
utserver -settingspath /opt/utorrent-server-alpha-v3_3/ &
echo UTORRENT INSTALADO COM SUCESSO  
echo.
echo..
echo...
