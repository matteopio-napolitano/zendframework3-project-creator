#!/bin/bash

TEXT_HL_LIGHTBLUE='\033[104m'
TEXT_HL_NC='\033[49m' # No Color
TEXT_WHITE='\033[97m'
TEXT_ORANGE='\033[0;33m'
TEXT_NC='\033[0m' # No Color

echo ""
echo -e "${TEXT_HL_LIGHTBLUE}${TEXT_WHITE}Zend Framework 3 Skeleton Application Installer v.0.2${TEXT_NC}${TEXT_HL_NC}"

if [ "$#" -ne 1 ] # check argument
then
	echo ""
    echo "This program creates a ZF3 Skeleton application at the specified path"
    echo "Usage: ./zf3install.sh /path/to/project"
    echo ""
    exit 1
fi

command -v php > /dev/null 2>&1 || { # check php installed
	echo ""
    echo "In order to run this program, you need to install PHP"
    echo "Unable to install ZF3!"
    echo ""
    exit 1
}

php -v | grep -i "PHP 7\.\d\.\d" > /dev/null || { #check php 7
	echo ""
    echo "In order to run this program, you need to install PHP version 7"
    echo "Unable to install ZF3!"
    echo ""
    exit 1
}

command -v composer > /dev/null 2>&1 || { # check composer
	echo ""
    echo "In order to run this program, you need to install composer"
    echo -n "Do you want to install composer (y/n)? "
    
    read proceed_install_composer
    if echo "$proceed_install_composer" | grep -iq "^y" ;then
	    echo -e "${TEXT_ORANGE}Installing composer...${TEXT_NC}"
        curl -sS https://getcomposer.org/installer | php
        mv composer.phar /usr/local/bin/composer
	else
		echo "Unable to install ZF3!"
        echo ""
        exit 1
	fi
}

echo ""
echo "This program will create a Zend Framework 3 Skeleton application at $1"
echo -n "Do you want to proceed (y/n)? "

read proceed_install
if echo "$proceed_install" | grep -iq "^y"
then
	echo -e "${TEXT_ORANGE}Installing Zend Framework 3 Skeleton application...${TEXT_NC}"
	composer create-project -sdev zendframework/skeleton-application $1
else
	echo "Aborting install"
	echo ""
	exit 1
fi