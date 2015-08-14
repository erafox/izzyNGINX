#!/bin/sh

#  izzy.sh
#  izzyNGINX
#
#  Created by enrique aka phuongph@ftech.vn on 8/7/15.
#  This script help you install NGINX, MariaDB, etc.. very easy
#
# Checking permissions
if [[ $EUID -ne 0 ]]; then
in_lib_echo_fail "Script nay can quyen root de chay..."
#in_lib_echo_fail "Uses: wget -qO ee rt.cx/ee && sudo bash ee"
exit 100
fi

# Define echo function
# Blue color
function in_lib_echo()
{
echo $(tput setaf 4)$@$(tput sgr0)
}
# White color
function in_lib_echo_info()
{
echo $(tput setaf 7)$@$(tput sgr0)
}
# Red color
function in_lib_echo_fail()
{
echo $(tput setaf 1)$@$(tput sgr0)
}

# Capture errors
function in_lib_error()
{
echo "[ `date` ] $(tput setaf 1)$@$(tput sgr0)"
exit $2
}

readonly in_linux_distro=$(lsb_release -i | awk '{print $3}')
readonly in_distro_version=$(cat /etc/redhat-release | awk '{ print $3}' | awk 'BEGIN { FS = "." } ; { print $1}')
readonly in_check_mysql=$(type mysql >/dev/null 2>&1 && echo "1" || echo "0")
readonly in_check_http=$(type httpd >/dev/null 2>&1 && echo "1" || echo "0")
readonly in_check_nginx=$(type nginx >/dev/null 2>&1 && echo "1" || echo "0")
readonly in_check_lsws=$(type /usr/local/lsws/bin/lswsctrl >/dev/null 2>&1 && echo "1" || echo "0")

# Checking linux distro
if [ "$in_linux_distro" != "Centos" ]; then
    in_lib_echo_fail "izzyNGINX (izzy) chi van hanh tren Centos"
    exit 100
fi

#install epel-release
yum install -y epel-release
#install development tools
yum groupinstall -y "Development Tools"

#check software
if ["$in_check_mysql"]; then
    in_lib_echo_fail "MySQL da duoc cai dat. Ban vui long go bo MySQL hien tai de tiep tuc"
    exit 100
fi
if ["$in_check_http"]; then
    in_lib_echo_fail "Apache da duoc cai dat. Ban vui long go bo Apache hien tai de tiep tuc"
    exit 100
fi
if ["$in_check_nginx"]; then
    in_lib_echo_fail "NGINX da duoc cai dat. Ban vui long go bo NGINX hien tai de tiep tuc"
    exit 100
fi
if ["$in_check_lsws"]; then
    in_lib_echo_fail "Litespeed da duoc cai dat. Ban vui long go bo Litespeed hien tai de tiep tuc"
    exit 100
fi

#install MariaDB 