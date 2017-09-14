if [ $1 -eq 1 ] ; then
    # Initial installation
    systemctl --no-reload preset fabio.service >/dev/null 2>&1 || :
fi
