getent group fabio >/dev/null || groupadd -r fabio
getent passwd fabio >/dev/null || useradd -r -g fabio -d /var/lib/fabio -s /sbin/nologin -c "fabio user" fabio
