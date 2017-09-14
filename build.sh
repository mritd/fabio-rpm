#!/bin/bash

FABIO_VERSION=$1
GO_VERSION=${GO_VERSION:-"1.8.3"}

if [ "" == "${FABIO_VERSION}" ];then
    echo -e "\033[31mError: FABIO_VERSION is blank!\033[0m"
    echo -e "\033[33mUse: \"$0 1.5.2\" to build fabio rpm.\033[0m"
    exit 1
fi

echo -e "\033[32mClean old files...\033[0m"
rm -f usr/bin/fabio etc/fabio/fabio.properties *.rpm


echo -e "\033[32mDownload fabio...\033[0m" 
if [ ! -d etc/fabio ]; then mkdir etc/fabio; fi
if [ ! -d usr/bin ]; then mkdir usr/bin; fi
wget https://raw.githubusercontent.com/fabiolb/fabio/v${FABIO_VERSION}/fabio.properties -O etc/fabio/fabio.properties
wget https://github.com/fabiolb/fabio/releases/download/v${FABIO_VERSION}/fabio-${FABIO_VERSION}-go${GO_VERSION}-linux_amd64 -O usr/bin/fabio
chmod +x usr/bin/fabio 

echo -e "\033[32mBuilding rpm...\033[0m"
fpm -s dir -t rpm -n "fabio" -v ${FABIO_VERSION} \
    --pre-install rpmscripts/preinstall.sh \
    --post-install rpmscripts/postinstall.sh \
    --pre-uninstall rpmscripts/preuninstall.sh \
    etc usr
