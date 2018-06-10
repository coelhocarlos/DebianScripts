#!/bin/bash
# dvdcopy.sh - A sample shell script to display a progress bar
# set counter to 0 
counter=0
(
# set infinite while loop
while :
do
cat <<EOF
XXX
$counter
Install_php() ( $counter%):
XXX
EOF
# increase counter by 10
(( counter+=10 ))
[ $counter -eq 100 ] && break
# delay it a specified amount of time i.e 1 sec
sleep 1
done
) |
dialog --title "File Copy" --gauge "Please wait" 7 70 0

Install_php() {
    echo " -------------- Installing PHP -------------- " 
    cd $DOWNDIR
    sudo apt-get install python-software-properties || local ERROR=1
    sudo add-apt-repository ppa:ondrej/php || local ERROR=1
    sudo apt-get update || local ERROR=1
    sudo aapt-get -y install php7.2 libapache2-mod-php7.2 || local ERROR=1
    sudo apt-get install php7.2-mysql php7.2-curl php7.2-json php7.2-cgi php7.2-xsl || local ERROR=1
    sudo apt-get -y install php7.2-mysql php7.2-curl php7.2-gd php7.2-intl php-pear php-imagick php7.2-imap php-memcache  php7.2-pspell php7.2-recode php7.2-sqlite3 php7.2-tidy php7.2-xmlrpc php7.2-xsl php7.2-mbstring php-gettext || local ERROR=1
    sudo systemctl restart apache2 || local ERROR=1
    sudo apt install php7.0-dev || local ERROR=1
    sudo systemctl restart apache2 || local ERROR=1
    sudo apt-get -y install php7.2-opcache php-apcu || local ERROR=1
    sudo systemctl restart apache2 || local ERROR=1
    sudo a2enmod ssl || local ERROR=1
    sudo a2ensite default-ssl || local ERROR=1
    sudo systemctl restart apache2 || local ERROR=1
    return $ERROR
}
