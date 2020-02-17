#!/usr/bin/env bash
#=================================================
# https://github.com/P3TERX/ca-certificates.crt
# Description: Update ca-certificates.crt
# Version: 1.0
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

set -e
[ $(uname) != Linux ] && {
    echo "This operating system is not supported."
    exit 1
}
[ $EUID != 0 ] && SUDO=sudo
$SUDO echo
Green_font_prefix="\033[32m"
Red_font_prefix="\033[31m"
Green_background_prefix="\033[42;37m"
Red_background_prefix="\033[41;37m"
Font_color_suffix="\033[0m"
INFO="[${Green_font_prefix}INFO${Font_color_suffix}]"
ERROR="[${Red_font_prefix}ERROR${Font_color_suffix}]"

echo -e "${INFO} Doanload ca-certificates.crt ..."
curl -s https://api.github.com/repos/P3TERX/ca-certificates.crt/releases/latest |
    grep "browser_download_url.*ca-certificates.crt" |
    cut -d '"' -f 4 |
    wget -Ni-

[ -s ca-certificates.crt ] || {
    echo -e "${ERROR} Unable to download ca-certificates.crt, network failure or API error."
    exit 1
}

echo -e "${INFO} Updating ca-certificates.crt ..."
$SUDO mkdir -p /etc/ssl/certs
$SUDO mv -f ca-certificates.crt /etc/ssl/certs/ca-certificates.crt &&
    echo -e "${INFO} ca-certificates.crt update completed !" ||
    {
        echo -e "${ERROR} ca-certificates.crt update failed !"
        exit 1
    }
