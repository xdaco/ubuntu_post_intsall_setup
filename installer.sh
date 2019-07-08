#!/usr/bin/env bash

# Imports
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
export SCRIPT_PATH=$SCRIPT_PATH
. $SCRIPT_PATH/utils.sh

###########################
# Local Console Colours
############################

BOLD="\e[1m"
CYAN="\e[36m"
GREEN="\e[32m"
BLUE="\e[34m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

############################
# Hostname
############################
DEFAULT_HOSTNAME="xdaco"
HOSTNAME=""

print_logo
pretty_header "--------------------------UBUNTU POST INSTALL SETUP-------------------------------"
pretty_header "..................................................................................."
# Check that we are root
if [ "$EUID" -ne 0 ]; then
    pretty_error "Please run as root (e.g. sudo)"
    exit 1
fi
pretty_header "SOFTWARE REPOSITORY UPDATE"
pretty_print "Updating Software catalog. Please wait......"
## Adding 32bit software support
sudo dpkg --add-architecture i386
## Adding Google Chrome repository
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
apt update >/dev/null 2>&1 & show_spinner
pretty_print "............................................."
apt update >/dev/null 2>&1 & show_spinner
pretty_print "Installaing available updates................"
apt upgrade -y >/dev/null 2>&1 & show_spinner
############################
# Essenstial Package Install
############################
ESSENTIAL_PACKAGE_LIST="build-essential ubuntu-restricted-extras libavcodec-extra libdvd-pkg gufw ppa-purge google-chrome-stable gnome-tweak-tool bleachbit vlc gimp calibre pinta flatpak gnome-software-plugin-flatpak gnome-tweak-tool synaptic shutter tlp tlp-rdw snapd at git can-utils x11vnc "
for PACKAGE_NAME in $ESSENTIAL_PACKAGE_LIST; do
    install_package $PACKAGE_NAME & show_spinner
done
echo -e ${GREEN}
sudo tlp start
echo -e ""${RESET}
## Install skype
SNAP_CLASSIC_LIST="sublime-text skype vscode slack"
for PACKAGE_NAME in $SNAP_CLASSIC_LIST; do
    install_snap_package $PACKAGE_NAME "--classic"
done
SNAP_LIST="spotify ghex-udt clementine"
for PACKAGE_NAME in $SNAP_LIST; do
    install_snap_package $PACKAGE_NAME
done
##Additional package installation
pretty_header "POWERLINE INSTALLATION"
pretty_print "Do you want to install powerline-status? Press 'Y' or 'y' to confirm."
read ans_powerline
if [ -z "$ans_powerline" ]; then
    pretty_error "No input received!"
    pretty_print "Skipping powerline-status installation "
elif [[ $ans_powerline == "Y" || $ans_powerline == "y" ]]; then
    pretty_header "Installating powerline-status and its dependencies...."
    install_pip_package "powerline-status"
    install_pip_package "powerline-gitstatus"
    ##Powerline configuration
    cp powerline_theme.json /usr/lib/python2.7/site-packages/powerline/config_files/themes/shell/default.json
    cp powerline_colorscheme.json /usr/lib/python2.7/site-packages/powerline/config_files/colorschemes/shell/default.json
    LINE='if [ -f /usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then source /usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh; fi'
    add_line "${LINE}" ~/.bashrc "Powerline Configuration"
    #Install Powerline Fonts
    echo -e ${GREEN}
    #install_package fonts-powerline
    git clone https://github.com/xdaco/powerline-fonts.git
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts
    powerline-daemon --replace
    source /etc/profile
    echo -e ""${RESET}
else
    pretty_print "Skipping powerline-status installation "
fi
