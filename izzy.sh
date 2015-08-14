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

# Checking linux distro
if [ "$in_linux_distro" != "Centos" ]; then
    in_lib_echo_fail "izzyNGINX (izzy) chi van hanh tren Centos"
    exit 100
fi

#install epel-release
yum install -y epel-release
#install development tools
yum groupinstall -y "Development Tools"
if ["$in_distro_version" == 5]
    wget 
fi
