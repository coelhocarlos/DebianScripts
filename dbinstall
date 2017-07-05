#!/bin/bash
# Bash script created by DEATH
# july 5th 2017
# pre installing
# apt-get install vsftpd nano


set -e

#Some housekeeping variables

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
reset=`tput sgr0`
UL=$(tput cuu1)
EL=$(tput el)
curdir=$(pwd)

#welcome screen

clear
echo "${green}"
echo "	|-------------------------------------------------------------------|"
echo "	|	Welcome to the intsall debian 9 apps by ${red}DEATH${green}   |"
echo "	|	This Script will install all the required prerequisites     |"
echo "	|	including apache2, server files, library files, etc.       |"
echo "	|-------------------------------------------------------------------|"
echo "${reset}"


if [ $(id -u) != "0" ]; then
    echo "You must be the superuser to run this script" >&2
    echo ""
    exit 1
fi

if [ -x $(command -v apt-get >/dev/null) ];then
	echo ""
else
	echo "You dont have apt-get... it is required"
	echo ""
	exit 1
fi

#Install file locations

checkiftrue()
{
	case "$1" in
	    [yY]|[yY][eE][sS])
	        return 0 ;;
	    [nN]|[nN][oO])
	        return 1 ;;
	esac
}

checkiffalse()
{
	case "$1" in
	    [yY]|[yY][eE][sS])
	        return 1 ;;
	    [nN]|[nN][oO])
	        return 0 ;;
	esac
}
