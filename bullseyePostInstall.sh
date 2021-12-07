#!/bin/bash
# Mon script de post installation serveur Debian 
# Compatible Debian 9 Stretch
# Jijai - 09/2016
# GPL
#from https://gitlab.com/tifredfr/debserver/blob/master/debserver8
#and 

# Pour télécharger le fichier : wget https://github.com/user/debianPostInstall/raw/master/stretchPostInstall.sh
#
# Syntaxe: # su - -c "./debian-postinstall.sh"
# Syntaxe: or # sudo ./debian-postinstall.sh
VERSION="0.1"

#=============================================================================
# Liste des applications ànstaller: A adapter a vos besoins
LISTE="vim curl puppet ssh sudo htop glances open-vm-tools"

#=============================================================================

# Test que le script est lance en root
if [ $EUID -ne 0 ]; then
  echo -e "\nLe script doit être lancé avec l'utilisateur root: # sudo $0" 1>&2
  exit 1
fi

#=============================================================================
# Test si version de Debian OK
#=============================================================================
if [ "$(cut -d. -f1 /etc/debian_version)" == "11.1" ]; then
        echo "Version compatible, début de l'installation"
else
        echo "Script non compatible avec votre version de Debian" 1>&2
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

#=============================================================================
# Install sudoers
#=============================================================================
echo -e "\n### Installation de sudoers"

apt-get install -y sudoers

#=============================================================================
# Install vim
#=============================================================================

echo -e "\n### Installation de vim"

apt-get install -y vim

#=============================================================================
# Install curl
#=============================================================================
echo -e "\n### Installation de curl"

apt-get install -y curl

#=============================================================================
# Install Glances
#=============================================================================
echo -e "\n### Installation de glances"

apt-get install -y glances

#=============================================================================
# Install puppet agent
#=============================================================================
echo -e "\n### Installation de puppet-agent"

apt-get install -y puppet-agent


#=============================================================================
# Install ssh
#=============================================================================

echo -e "\n### Installation de ssh"

apt-get install -y ssh

#=============================================================================

echo -e "\n### Configuration finie. Il faut vous dénnecter/rconnecter pour que les modifications prennents effets"

# Fin du script
