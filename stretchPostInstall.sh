#!/bin/bash
# Mon script de post installation serveur Debian 
# Compatible Debian 9 Stretch
# Jijai - 09/2016
# GPL
#
# Syntaxe: # su - -c "./debian-postinstall.sh"
# Syntaxe: or # sudo ./debian-postinstall.sh
VERSION="0.1"

#=============================================================================
# Liste des applications ànstaller: A adapter a vos besoins
LISTE="vim curl puppet ssh"
#=============================================================================

# Test que le script est lance en root
if [ $EUID -ne 0 ]; then
  echo -e "\nLe script doit être lancé avec l'utilisateur root: # sudo $0" 1>&2
  exit 1
fi


# Mise a jour de la liste des depots
#-----------------------------------

# Retrait du DVD des sources apt 
sed -i 's/deb cdrom:/#deb cdrom:/g' /etc/apt/sources.list

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
