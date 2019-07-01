#!/usr/bin/env bash

###########################
# Colours
###########################

BOLD="\e[1m"
CYAN="\e[36m"
GREEN="\e[32m"
BLUE="\e[34m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

###########################
# Functions
###########################

pretty_print() {
    echo -e "=> ${GREEN}${1}${RESET}"
}

pretty_error() {
    echo ""
    echo -e "${RED}${1}${RESET}"
    echo ""
}

pretty_header() {
    echo ""
    echo -e "${BOLD}${BLUE}${1}${RESET}"
    echo ""
}

pretty_line() {
    echo -e "##############################################"
}

logo() {
    echo "                                                              "
    echo "                                                              "
    echo "                     88                                       "
    echo "                     88                                       "
    echo "                     88                                       "
    echo "8b,     ,d8  ,adPPYb,88  ,adPPYYba,   ,adPPYba,   ,adPPYba,   "
    echo " \`Y8, ,8P'  a8\"    \`Y88  \"\"     \`Y8  a8\"     \"\"  a8\"     \"8a  "
    echo "   )888(    8b       88  ,adPPPPP88  8b          8b       d8  "
    echo " ,d8\" \"8b,  \"8a,   ,d88  88,    ,88  \"8a,   ,aa  \"8a,   ,a8\"  "
    echo "8P'     \`Y8  \`\"8bbdP\"Y8  \`\"8bbdP\"Y8   \`\"Ybbd8\"'   \`\"YbbdP\"'   "
    echo "  _   _             _                 _                     "
    echo " | | | |           | |               | |                    "
    echo " | |_| |__   ___   | |_ _   ___  __  | | _____   _____ _ __ "
    echo " | __| '_ \ / _ \  | __| | | \ \/ /  | |/ _ \ \ / / _ \ '__|"
    echo " | |_| | | |  __/  | |_| |_| |>  <   | | (_) \ V /  __/ |   "
    echo "  \__|_| |_|\___|   \__|\__,_/_/\_\  |_|\___/ \_/ \___|_|   "
    echo "                                 _._"
    echo "                                /_ _\`."
    echo "                                (.X.)|"
    echo "                                |\_/'|"
    echo "                                )____\`\\"
    echo "                               //_V _\ \ "
    echo "                              ((  |  \`(_)"
    echo "                             / \> '   / \ "
    echo "                             \  \.__./  / "
    echo "                              \`-'    \`-'"
    echo ""
}

logo_big() {
    echo ""
    echo "                             dddddddd                                                      "
    echo "                             d::::::d                                                      "
    echo "                             d::::::d                                                      "
    echo "                             d::::::d                                                      "
    echo "                             d:::::d                                                       "
    echo "xxxxxxx      xxxxxxx ddddddddd:::::d   aaaaaaaaaaaaa      cccccccccccccccc   ooooooooooo   "
    echo " x:::::x    x:::::xdd::::::::::::::d   a::::::::::::a   cc:::::::::::::::c oo:::::::::::oo "
    echo "  x:::::x  x:::::xd::::::::::::::::d   aaaaaaaaa:::::a c:::::::::::::::::co:::::::::::::::o"
    echo "   x:::::xx:::::xd:::::::ddddd:::::d            a::::ac:::::::cccccc:::::co:::::ooooo:::::o"
    echo "    x::::::::::x d::::::d    d:::::d     aaaaaaa:::::ac::::::c     ccccccco::::o     o::::o"
    echo "     x::::::::x  d:::::d     d:::::d   aa::::::::::::ac:::::c             o::::o     o::::o"
    echo "     x::::::::x  d:::::d     d:::::d  a::::aaaa::::::ac:::::c             o::::o     o::::o"
    echo "    x::::::::::x d:::::d     d:::::d a::::a    a:::::ac::::::c     ccccccco::::o     o::::o"
    echo "   x:::::xx:::::xd::::::ddddd::::::dda::::a    a:::::ac:::::::cccccc:::::co:::::ooooo:::::o"
    echo "  x:::::x  x:::::xd:::::::::::::::::da:::::aaaa::::::a c:::::::::::::::::co:::::::::::::::o"
    echo " x:::::x    x:::::xd:::::::::ddd::::d a::::::::::aa:::a cc:::::::::::::::c oo:::::::::::oo "
    echo "xxxxxxx      xxxxxxxddddddddd   ddddd  aaaaaaaaaa  aaaa   cccccccccccccccc   ooooooooooo   "
    echo "                                                                    "
    echo "                                                         .88888888:."
    echo "                                                        88888888.88888."
    echo "                                                       .8888888888888888."
    echo "                                                       888888888888888888 "
    echo "                                                       88' _\`88'_  \`88888 "
    echo "                                                       88 88 88 88  88888 "
    echo "                                                       88_88_::_88_:88888 "
    echo "                                                       88:::,::,:::::8888 "
    echo "                                                       88\`:::::::::'\`8888 "
    echo "                                                      .88  \`::::'    8:88. "
    echo "                                                     8888            \`8:888."
    echo "                                                   .8888'             \`888888."
    echo "                                                  .8888:..  .::.  ...:'8888888:."
    echo "                                                 .8888.'     :'     \`'::\`88:88888 "
    echo "                                                .8888        '         \`.888:8888."
    echo "                                               888:8         .           888:88888"
    echo "                                             .888:88        .:           888:88888:"
    echo "                                             8888888.       ::           88:888888"
    echo "                                             \`.::.888.      ::          .88888888"
    echo "                                            .::::::.888.    ::         :::\`8888'.:."
    echo "                                           ::::::::::.888   '         .:::::::::::: "
    echo "                                           ::::::::::::.8    '      .:8::::::::::::."
    echo "                                          .::::::::::::::.        .:888:::::::::::::"
    echo "                                          :::::::::::::::88:.__..:88888:::::::::::'"
    echo "                                           \`'.:::::::::::88888888888.88:::::::::'"
    echo "                                                \`':::_:' -- '' -'-' \`':_::::'\`"
    echo ""

}

print_logo() {
    if [ $(tput lines) -ge 47 -a $(tput cols) -ge 91 ]; then
        logo_big
    else
        logo
    fi
}

print_system_info() {
    uname -a
    lsb_release -a
    cmake --version
}

install_package() {
    PACKAGE=$1
    echo -e ${GREEN}
    if dpkg -s ${PACKAGE} | grep -q -w "Status: install ok installed" >/dev/null 2>&1; then
        echo -e ${YELLOW}
        echo "\"${PACKAGE}\" already installed."
        echo -e ""${RESET}
        return
    else
        pretty_error "\"${PACKAGE}\" not found. Installing now..."
        apt install -y ${PACKAGE} >/dev/null 2>&1
    fi
    echo -e ${GREEN}
    if dpkg -s ${PACKAGE} | grep -q -w "Status: install ok installed" >/dev/null 2>&1; then
        pretty_print "\"${PACKAGE}\"............installed"
    else
        pretty_error "\"${PACKAGE}\"............failed"
    fi
}

install_pip_package() {
    ##Additional pip flag
    echo -e ${GREEN}
    LEGACY_PIP_VERSION="9.0.1"
    if grep $LEGACY_PIP_VERSION <<<$(pip --version | grep $LEGACY_PIP_VERSION); then
        PIP_FLAG="--format=legacy"
    else
        PIP_FLAG=""
    fi
    PACKAGE=$1
    if pip list | grep -w ${PACKAGE} >/dev/null 2>&1; then
        echo -e ${YELLOW}
        echo "\"${PACKAGE}\" already installed."
        echo -e ""${RESET}
        return
    else
        echo -e ${RED}
        echo "\"${PACKAGE}\" not found. Installing now..."
        echo -e ${GREEN}
        pip install ${PACKAGE} >/dev/null 2>&1
        echo -e ""${RESET}
    fi
    if pip list | grep -w ${PACKAGE} >/dev/null 2>&1; then
        echo -e ${GREEN}
        echo "\"${PACKAGE}\"............installed"
        echo -e ""${RESET}
    else
        echo -e ${RED}
        echo "\"${PACKAGE}\"............failed"
        echo -e ""${RESET}
    fi
}

install_snap_package() {
    echo -e ${GREEN}
    PACKAGE=$1
    CLASSIC_FLAG=$2
    if snap list | grep -w ${PACKAGE} >/dev/null 2>&1; then
        echo -e ${YELLOW}
        echo "\"${PACKAGE}\" already installed."
        echo -e ""${RESET}
        return
    else
        echo -e ${RED}
        echo "\"${PACKAGE}\" not found. Installing now..."
        echo -e ${GREEN}
        if [ -z "$2" ]; then
            snap install ${PACKAGE} >/dev/null 2>&1
        else
            snap install ${PACKAGE} $CLASSIC_FLAG >/dev/null 2>&1
        fi
        echo -e ${RESET}
    fi
    if snap list | grep -w ${PACKAGE} >/dev/null 2>&1; then
        echo -e ${GREEN}
        echo "\"${PACKAGE}\"............installed"
        echo -e ""${RESET}
    else
        echo -e ${RED}
        echo "\"${PACKAGE}\"............failed"
        echo -e ""${RESET}
    fi
}

function add_line() {
    LINE="$1"
    FILE=$2
    COMMENT=$3
    grep -F -q "${LINE}" ${FILE} || (echo -e "## ${COMMENT}" >>${FILE} && echo ${LINE} >>${FILE})
}
