#!/bin/bash
# Mon script de post installation serveur Debian 
# Compatible Debian 8 Stretch
# Jijai - 09/2016
# GPL
#
# Syntaxe: # su - -c "./debian-postinstall.sh"
# Syntaxe: or # sudo ./debian-postinstall.sh
VERSION="0.1"

#https://gitlab.com/tifredfr/debserver/tree/master

#=============================================================================
# Liste des applications ànstaller: A adapter a vos besoins
LISTE="vim puppet-agent ssh sudo htop glances curl openjdk-8-jdk"
#=============================================================================

# Test que le script est lance en root
if [ $EUID -ne 0 ]; then
  echo -e "\nLe script doit être lancé avec l'utilisateur root: # sudo $0" 1>&2
  exit 1
fi

#=============================================================================
# Test si version de Debian OK ----
#=============================================================================
if [ "$(cut -d. -f1 /etc/debian_version)" == "8" ]; then
        echo "Version compatible, début de l'installation"
else
        echo "Script non compatible avec votre version de Debian" 1>&2
        exit 1
fi


# Mise a jour de la liste des depots
#-----------------------------------
echo "
deb http://deb.debian.org/debian/ jessie main contrib non-free
#deb-src http://deb.debian.org/debian jessie main contrib non-free

deb http://deb.debian.org/debian/ jessie-updates main contrib non-free
#deb-src http://deb.debian.org/debian/ jessie-updates main contrib non-free

deb http://deb.debian.org/debian-security jessie/updates main contrib non-free
#deb-src http://deb.debian.org/debian-security jessie/updates main contrib non-free

###Third Parties Repos
## Deb-multimedia.org
#deb http://www.deb-multimedia.org jessie main non-free

## Debian Backports
deb http://deb.debian.org/debian jessie-backports main


## HWRaid
# wget -O - http://hwraid.le-vert.net/debian/hwraid.le-vert.net.gpg.key | sudo apt-key add -
#deb http://hwraid.le-vert.net/debian jessie main" > /etc/apt/sources.list

# Update 
echo -e "\n### Mise a jour de la liste des depots\n"
apt update

# Upgrade
echo -e "\n### Mise a jour du systeme\n"
apt -y upgrade

# Installation
echo -e "\n### Installation des logiciels suivants: $LISTE\n"
apt -y install $LISTE

# Configuration
#--------------



echo -e "\n### Configuration finie. Il faut vous dénnecter/rconnecter pour que les modifications prennents effets"

# Fin du script
