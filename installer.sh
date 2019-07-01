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
apt update >/dev/null 2>&1
pretty_print "............................................."
apt update >/dev/null 2>&1
pretty_print "Installaing available updates................"
apt upgrade -y >/dev/null 2>&1
############################
# Essenstial Package Install
############################
ESSENTIAL_PACKAGE_LIST="build-essential ubuntu-restricted-extras vlc gimp calibre pinta flatpak gnome-software-plugin-flatpak gnome-tweak-tool synaptic shutter tlp tlp-rdw snapd at git can-utils x11vnc "
for PACKAGE_NAME in $ESSENTIAL_PACKAGE_LIST; do
    install_package $PACKAGE_NAME
done
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# wget https://repo.skype.com/latest/skypeforlinux-64.deb
# dpkg -i skypeforlinux-64.deb
# apt-get install -f
# dpkg -i google-chrome-stable_current_amd64.deb
# apt-get install -f
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
    install_pip_package "defusedxml"
    ##Powerline configuration
    cp powerline_theme.json /usr/lib/python2.7/site-packages/powerline/config_files/themes/shell/default.json
    cp powerline_colorscheme.json /usr/lib/python2.7/site-packages/powerline/config_files/colorschemes/shell/default.json
    LINE_1='export ENV=/etc/profile'
    add_line "${LINE_1}" /etc/profile "Additional Powerline Configuration for root shell"
    LINE_2='if [ -f /usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then source /usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh; fi'
    add_line "${LINE_2}" /etc/profile "Powerline Configuration"
    add_line "${LINE_2}" ~/.bashrc "Powerline Configuration"
    cp powerline_fonts/* /usr/share/fonts/ttf/
    echo -e ${GREEN}
    powerline-daemon --replace
    source /etc/profile
    echo -e ""${RESET}
else
    pretty_print "Skipping powerline-status installation "
fi
